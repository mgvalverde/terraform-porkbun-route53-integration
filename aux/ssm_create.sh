source .env && \
aws ssm put-parameter \
    --name "/porkbun/api_key" \
    --value "${PORKBUN_API_KEY}" \
    --type "SecureString" \
    --description "Porkbun API key" && \
aws ssm put-parameter \
    --name "/porkbun/secret_key" \
    --value "${PORKBUN_SECRET_API_KEY}" \
    --type "SecureString" \
    --description "Porkbun Secret key"


