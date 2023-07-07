import NextAuth, { NextAuthOptions } from "next-auth"
import { Adapter } from "next-auth/adapters"
import GithubProvider from "next-auth/providers/github"
import { DynamoDBAdapter } from "@auth/dynamodb-adapter"
import { DynamoDB } from "@aws-sdk/client-dynamodb"
import { DynamoDBDocument } from "@aws-sdk/lib-dynamodb"

const dynamodb = new DynamoDB({
  region: "ap-southeast-1",
  endpoint: process.env.DYNAMODB_ENDPOINT_URL,
})

export const dynamodbDocument = DynamoDBDocument.from(dynamodb, {
  marshallOptions: {
    convertClassInstanceToMap: true,
    convertEmptyValues: true,
    removeUndefinedValues: true,
  },
})

const adapter = DynamoDBAdapter(dynamodbDocument, {
  tableName: "CustomTableName",
  partitionKey: "CustomPK",
  sortKey: "CustomSK",
  indexName: "CustomGSI1",
  indexPartitionKey: "CustomGSI1PK",
  indexSortKey: "CustomGSI1SK",
}) as Adapter

export const authOptions: NextAuthOptions = {
  adapter,
  providers: [
    GithubProvider({
      clientId: process.env.GITHUB_ID,
      clientSecret: process.env.GITHUB_SECRET,
    }),
  ],
  callbacks: {
    async jwt({ token }) {
      token.userRole = "admin"
      return token
    },
  },
}

export default NextAuth(authOptions)
