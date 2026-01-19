{% macro generate_schema_name(custom_schema_name, node) -%}
    {# 
       If a custom schema (like 'staging') is defined in dbt_project.yml, 
       use it EXACTLY. Do not append it to the profile schema.
    #}
    {%- if custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}
    {%- else -%}
        {{ target.schema }}
    {%- endif -%}
{%- endmacro %}