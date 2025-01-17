# CDS-Library: Clinical Decision Support File Library
The CDS-Library stores common files necessary to make the [Coverage Requirements Discovery (CRD)](https://github.com/mcode/CRD), [Documentation Templates and Rules (DTR)](https://github.com/mcode/dtr) and [Prior Authorization Support (PAS)](https://github.com/HL7-DaVinci/prior-auth) use cases work. These use cases are being developed as part of the [Da Vinci Project](http://www.hl7.org/about/davinci/index.cfm?ref=common) within the [HL7 Standards Organization](http://www.hl7.org/).

## CRD-DTR
The "rule" files necessary to make the [Coverage Requirements Discovery (CRD)](https://github.com/mcode/CRD) and [Documentation Templates and Rules (DTR)](https://github.com/mcode/dtr) use cases work

## Examples
The "rule" files for CRD and DTR that were not created as part of the reference implementation

To run the rule sets under the Examples folder with the test-ehr, you need to load the data for the rule sets from test-ehr repo by running the following command:
>gradle loadData 

## PriorAuth
Rules the [Prior Authorization Support (PAS)](https://github.com/HL7-DaVinci/prior-auth) reference implementation uses for deciding on the approval of a Claim.

## RuleUtils
A java library for helping to process CQL as well as converting CQL to ELM for execution.
