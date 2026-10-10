CASE_FIELD_MAP = {

    "subject":"Subject",
    "description":"Description",
    "priority":"Priority",
    "caseorigin":"Origin"
}

def validate_case_fields_data(case_record, **expected):
    #Compare a Case record (dict) with expected values.
    #Usage: Validate Case Fields    ${case_record}    subject=${subject}    priority=${priority}

    errors=[]
    for field, expected_value in expected.items():
        sf_field = CASE_FIELD_MAP(field,field)
        actual_value = case_record.get(sf_field)
        print(f"{field} | Expected: {expected_value} | Actual:{actual_value}")
        if str(actual_value) != str(expected_value):
            errors.append(f"{field} | Expected: {expected_value}, got '{actual_value}'")
    if errors:
        raise    AssertionError("Validation failed:\n" + "\n".join(errors))


    