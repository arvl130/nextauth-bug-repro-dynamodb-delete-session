#! /bin/sh -e 

aws dynamodb \
  --no-cli-pager \
  --endpoint-url http://localhost:8000 \
  create-table \
  --table-name CustomTableName \
  --attribute-definitions \
    AttributeName=CustomPK,AttributeType=S \
    AttributeName=CustomSK,AttributeType=S \
    AttributeName=CustomGSI1PK,AttributeType=S \
    AttributeName=CustomGSI1SK,AttributeType=S \
  --key-schema \
    AttributeName=CustomPK,KeyType=HASH \
    AttributeName=CustomSK,KeyType=RANGE \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --global-secondary-indexes \
    "
      [
        {
          \"IndexName\": \"CustomGSI1\",
          \"Projection\": {
            \"ProjectionType\": \"ALL\"
          },
          \"KeySchema\": [
            {
              \"AttributeName\": \"CustomGSI1PK\",
              \"KeyType\": \"HASH\"
            },
            {
              \"AttributeName\": \"CustomGSI1SK\",
              \"KeyType\": \"RANGE\"
            }
          ],
          \"ProvisionedThroughput\": {
            \"ReadCapacityUnits\": 5,
            \"WriteCapacityUnits\": 5
          }
        }
      ]
    "
aws dynamodb \
  --no-cli-pager \
  --endpoint-url http://localhost:8000 \
  update-time-to-live \
  --table-name CustomTableName \
  --time-to-live-specification Enabled=true,AttributeName=expires

