library IPledgeRule version '0.1.0'
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0' called FHIRHelpers


parameter Patient Patient
parameter medication_request MedicationRequest
parameter medication_dispense MedicationDispense
parameter medication_statement MedicationStatement

define RULE_APPLIES:
    true

define PRIORAUTH_REQUIRED:
  false

define DOCUMENTATION_REQUIRED:
  true
  
define RESULT_InfoLink:
    'https://www.accessdata.fda.gov/drugsatfda_docs/rems/IPledge_2020_08_04_REMS_Full.pdf'

define RESULT_QuestionnaireOrderUri:
    'Questionnaire/IPledgeRemsPatientEnrollmentCanGetPregnant'

define RESULT_QuestionnairePrescriberKnowledgeAssessmentUri:
    'Questionnaire/IPledgeRemsPatientEnrollmentCannotGetPregnant'

define RESULT_QuestionnairePrescriberEnrollmentUri:
    'Questionnaire/IPledgeRemsPrescriberEnrollmentForm'

define RESULT_requestId:
  medication_request

define RESULT_dispense:
  medication_dispense