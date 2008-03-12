# Adds a way to export dates to an HL7 TS data type. This will yield a TS
# with a specificity down to the day. Times will be assumed to be local times.
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:hl7_ts] = "%Y%m%d"