library TIRFRule version '0.1.0'
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
    'https://www.accessdata.fda.gov/drugsatfda_docs/rems/TIRF_2022_08_17_REMS_Document.pdf'
define INFO_PATIENT_PatientCounselingGuide:
    'https://www.accessdata.fda.gov/drugsatfda_docs/rems/TIRF_2022_08_17_Patient_Counseling_Guide.pdf'
define INFO_PATIENT_PatientFAQ:
    'https://tirfstorageproduction.blob.core.windows.net/tirf-public/tirf-patientfaq-frequently-asked-questions.pdf'
define INFO_PRESCRIBER_PrescriberEducation:
    'https://www.accessdata.fda.gov/drugsatfda_docs/rems/TIRF_2022_08_17_Prescriber_Education.pdf'
define INFO_PRESCRIBER_PrescriberFAQ:
    'https://tirfstorageproduction.blob.core.windows.net/tirf-public/tirf-prfaq-frequently-asked-questions.pdf'

define RESULT_QuestionnaireOrderUri:
    'Questionnaire/TIRFRemsPatientEnrollment'

define RESULT_QuestionnairePrescriberEnrollmentUri:
    'Questionnaire/TIRFPrescriberEnrollmentForm'

define RESULT_QuestionnairePrescriberKnowledgeAssessmentUri:
    'Questionnaire/TIRFPrescriberKnowledgeAssessment'

define RESULT_requestId:
  medication_request

define RESULT_dispense:
  medication_dispense