#### dbt Commands

- Execute ```dbt test``` to run all **generic** and **singular** tests in your project.
- Execute ```dbt test --select test_type:generic``` to run only **generic** tests in your project.
- Execute ```dbt test --select test_type:singular``` to run only **singular** tests in your project.