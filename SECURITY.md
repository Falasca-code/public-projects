# Farol — Security Review

## Security boundary

The Farol application is responsible for authentication, authorization, session
handling, input validation, API and backend security, frontend security,
secret handling, database access, logging, auditability, dependencies, build
and container hardening, and its Zabbix integration.

The client infrastructure is responsible for publication and perimeter policy:
DNS, NAT, firewalls, WAFs, HAProxy, NGINX, F5, Traefik, VPNs, certificates,
and Internet exposure. These are deployment options, not Farol runtime
dependencies. Farol can run behind any publication layer or directly on its
internal application port in a controlled network.

Recommended deployment controls—HTTPS where appropriate, restricted access,
no externally published PostgreSQL or backend ports, and the client's internal
security policies—must be applied by the installation environment and must not
be interpreted as a requirement for one specific edge product.

## V1 architectural rules

- Browser → Farol backend → Zabbix API. `ZABBIX_TOKEN` is server-side only and
  must never be returned to a browser, included in frontend variables/bundles,
  logged, or exposed in errors.
- Zabbix access is read-only. V1 does not change Zabbix or customer systems.
- Farol v1 does not access switches directly: no SNMP, SSH, Telnet, NETCONF,
  RESTCONF, switch APIs, VLAN/port changes, or device configuration.
- The Zabbix Play is development-only and is not required for customer
  installation.

## Configuration and secrets

Copy `deploy/.env.example` to `.env`, provide values through the client's
secret-management process, and never commit `.env`, credentials, tokens,
private keys, database dumps, or production logs. Rotate any credential that
has appeared in Git history; removing it from the working tree does not revoke
it.

## Evidence-based review (2026-09-14)

ID: SEC-001  
Area: Secrets / configuration  
Test: `rg -n -i 'PASSWORD|PASSWD|SECRET|TOKEN|API_KEY|PRIVATE_KEY|JWT_SECRET|SESSION_SECRET|ZABBIX_TOKEN|POSTGRES_PASSWORD|DATABASE_URL|Authorization|Bearer|BEGIN RSA|BEGIN OPENSSH' .` (excluding dependency artifacts)  
Result: No Farol credential value was found in the reviewed deployment package; values in `.env.example` are placeholders.  
Expected: No real credentials are versioned.  
Status: PASS  
Severity: INFO  
Correction: Added `.gitignore` rules and this policy.

ID: SEC-002  
Area: Architecture / publication boundary  
Test: Review of README and deployment documentation.  
Result: Existing installation text required DNS and TLS; it has been changed to deployment guidance.  
Expected: No dependency on Traefik, public DNS, NAT, WAF, or public HTTPS.  
Status: PASS  
Severity: INFO  
Correction: Documentation updated.

ID: SEC-003  
Area: Application security / authentication / API / containers / database  
Test: Repository inventory.  
Result: Backend source, tests, and production Compose are not included in this repository, so runtime login, IDOR, CSRF, CORS, rate limiting, SQL injection, SSRF, XSS, container privileges, and PostgreSQL exposure could not be executed or proven here.  
Expected: Runtime tests and configuration review against the actual release artifacts.  
Status: PENDING  
Severity: MEDIUM  
Correction: Run the application-level test plan against the release containing backend, frontend, and Compose.

## Classification

Current repository result: **SEC-1 — Observação**.  
`BLOCK DEPLOY: NO` for this documentation package; production approval remains
pending the runtime review identified as SEC-003. SEC-3 and SEC-4 findings are
production blockers.

## Test plan for the complete release

Verify login/logout, expiry and invalid sessions, unauthenticated access,
protected endpoints, ID changes (IDOR), cookie flags, input validation,
parameterized queries, CSRF/CORS, rate limits, sanitized errors/logs, absence of
the Zabbix token in browser/network/bundles, and Compose least privilege.
