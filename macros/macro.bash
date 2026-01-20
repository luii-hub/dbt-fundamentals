# This macro generates a source for the specified schema and database.
# Usage example:

dbt run-operation generate_source --args '{"schema_name": "raw", "database_name": "jaffle_shop"}'

# Output:

# sources:
#   - name: raw
#     tables:
#       - name: jaffle_shop_customers
#       - name: jaffle_shop_orders
#       - name: stripe_payments