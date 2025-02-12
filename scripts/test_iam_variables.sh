ARLAS_CLI_CONF_FILE=/tmp/arlas-cli-tests.yaml

ORG1=org1.com
ORG2=org2.com

# OWNER OF ORG1
USER1_ORG1=user1@${ORG1}

# SIMPLE USER OF ORG1 and ORG2
USER2_ORG1_ORG2=user2@${ORG1}

# OWNER USER OF ORG1, but do not provide org-filter in tokens
USER3_ORG1=user3@${ORG1}

#OWNER OF ORG2
USER_ORG2=user@${ORG2}

# USER WITHOUT AN ORG
ORPHAN=orphan@org.com

# USER WITHOUT AN ORG
ORPHAN_WITH_ORG_FILTER=orphan2@org.com

#GLOBAL ADMIN
ADMIN=tech@gisaia.com

IS_USER=True
IS_OWNER=False
