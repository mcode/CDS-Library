library TIRFPrepopulation  version '0.1.0'
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "RXNORM": 'http://www.nlm.nih.gov/research/umls/rxnorm'

valueset "OpioidValueset": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1032.34'

code "Oncologist":'394592004' from "SNOMED-CT"

parameter device_request DeviceRequest
parameter service_request ServiceRequest
parameter medication_request MedicationRequest



context Patient

define Today: Today()
define "Opioid": [Medication: "OpioidValueset"]
define "MedList": [MedicationStatement] M
  where M.status.value = 'active' and M.medication is Reference

define "MedDict":
(
  [MedicationStatement] MS
    where date from MS.dateAsserted 2 years or less on or before Today()
      and MS.medication is Reference or MS.medication in "OpioidValueset"
) Rx
    let Med: if Rx.medication is Reference then singleton from ([Medication] M where M.id = (Last(Split((Rx.medication as FHIR.Reference).reference, '/')))) else null
        return {"medication": Med, "medicationStatement": Rx}


define function GetFreq(MedDict List<Tuple{medication Medication, medicationStatement MedicationStatement}>, Index Integer):
    if exists MedDict[Index] then
        (singleton from MedDict[Index].medicationStatement.dosage) D
            // could be pretty printed a bit by having a display for the code
            return ToString(D.timing.repeat.frequency.value) + ' per ' + ToString(D.timing.repeat.period.value) + '' + D.timing.repeat.periodUnit.value
    else null

define function GetRoute(MedDict List<Tuple{medication Medication, medicationStatement MedicationStatement}>, Index Integer):
    if exists MedDict[Index] then
        (singleton from MedDict[Index].medicationStatement.dosage) D
            return {FHIRHelpers.ToCode(singleton from D.route.coding)}
    else null
define function GetDose(MedDict List<Tuple{medication Medication, medicationStatement MedicationStatement}>, Index Integer):
    if exists MedDict[Index] then
        (singleton from (singleton from MedDict[Index].medicationStatement.dosage).doseAndRate) D
            let Dose: if D.dose is Quantity then (ToString(D.dose.value.value) + ' ' + D.dose.unit.value) else null
            return Dose
    else null
define function GetForm(MedDict List<Tuple{medication Medication, medicationStatement MedicationStatement}>, Index Integer):
    if exists MedDict[Index] then
        (singleton from MedDict[Index].medication.form.coding) F
            return {FHIRHelpers.ToCode(F)}
    else null
define function GetMoiety(MedDict List<Tuple{medication Medication, medicationStatement MedicationStatement}>, Index Integer):
    if exists MedDict[Index] then
        (singleton from MedDict[Index].medication.ingredient) I
            let MoietyIngredient: if I.item is CodeableConcept then (singleton from I.item.coding) else null
            return {FHIRHelpers.ToCode(MoietyIngredient)}
    else null
define function GetStrength(MedDict List<Tuple{medication Medication, medicationStatement MedicationStatement}>, Index Integer):
    if exists MedDict[Index] then
        ((singleton from MedDict[Index].medication.ingredient).strength) I
            let Denominator: if I.denominator.value.value = 1 then I.denominator.unit.value else (ToString(I.denominator.value.value) + ' ' + I.denominator.unit.value)
            return ToString(I.numerator.value.value) + I.numerator.unit.value + '/' + Denominator
    else null
// not the most interoperable way to do this, but until the table supports choice over text box not much to do about this
define "Frequency1": GetFreq("MedDict", 0)
define "Frequency2": GetFreq("MedDict", 1)
define "Frequency3": GetFreq("MedDict", 2)
define "Route1": GetRoute("MedDict", 0)
define "Route2": GetRoute("MedDict", 1)
define "Route3": GetRoute("MedDict", 2)
define "Dose1": GetDose("MedDict", 0)
define "Dose2": GetDose("MedDict", 1)
define "Dose3": GetDose("MedDict", 2)
define "Form1": GetForm("MedDict", 0)
define "Form2": GetForm("MedDict", 1)
define "Form3": GetForm("MedDict", 2)
define "Moiety1": GetMoiety("MedDict", 0)
define "Moiety2": GetMoiety("MedDict", 1)
define "Moiety3": GetMoiety("MedDict", 2)
define "Strength1": GetStrength("MedDict", 0)
define "Strength2": GetStrength("MedDict", 1)
define "Strength3": GetStrength("MedDict", 2)