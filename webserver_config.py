"""Default configuration for the Airflow webserver"""
import os

from flask_appbuilder.security.manager import AUTH_LDAP

AUTH_TYPE = AUTH_LDAP
AUTH_LDAP_SERVER = "ldap://vm-adds-05.hcaskona.com:389"
AUTH_LDAP_USE_TLS = False

AUTH_LDAP_SEARCH = "dc=hcaskona,dc=com"
AUTH_LDAP_UID_FIELD = "cn"
AUTH_LDAP_BIND_USER = "cn=airflow-datapl-ldap,OU=Services,OU=Accounts,DC=hcaskona,DC=com"
AUTH_LDAP_BIND_PASSWORD = "sL68dboQpojgnN8"

AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Public"
AUTH_LDAP_FIRSTNAME_FIELD = "givenName"
AUTH_LDAP_LASTNAME_FIELD = "sn"
AUTH_LDAP_EMAIL_FIELD = "mail"

AUTH_ROLES_MAPPING = {
    "cn=airflow-datapl-ldap,ou=Services,ou=Accounts,dc=hcaskona,dc=com": ["User"],
    # "cn=Marketing,ou=Groups,dc=local,dc=host": ["User"],
    # "cn=Data_science,ou=Groups,dc=local,dc=host": ["User"],
    # "cn=Admin,ou=Groups,dc=local,dc=host": ["Admin"],
}

AUTH_LDAP_GROUP_FIELD = "memberOf"

AUTH_ROLES_SYNC_AT_LOGIN = True

PERMANENT_SESSION_LIFETIME = 7200
