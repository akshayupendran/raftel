import os
import csv
from datetime import datetime, timedelta

# Local directory where the CSV files are stored
downloaded_files_directory = 'NAV'

# Function to find the last working day (weekday) from today
def find_last_working_day():
    current_date = datetime.now() - timedelta(days=1)  # Start from yesterday
    while current_date.weekday() >= 5:  # 5 and 6 correspond to Saturday and Sunday
        current_date -= timedelta(days=1)
    return current_date

# Calculate the date for the last working day from today
last_working_day = find_last_working_day()

# Format the last working day date in the required format
last_working_day_formatted = last_working_day.strftime('%Y%m%d')

# Full path for the CSV file of the last working day
latest_csv_path = os.path.join(downloaded_files_directory, f'{last_working_day_formatted}.csv')

# Term to search for in each line
search_term = 'Schemes ('

# Lists to store the extracted information
scheme_types = []
scheme_subtypes = []
scheme_subsubtypes = []

# Read the CSV file of the last working day and extract information
with open(latest_csv_path, mode='r', newline='') as file:
    csv_reader = csv.reader(file, delimiter=',')
    for row in csv_reader:
        for field in row:
            if search_term in field:
                # Extract information from the line
                parts = field.split(' ( ')
                if len(parts) == 2:
                    scheme_type = parts[0].strip()
                    scheme_subtype = parts[1].replace(')', '').strip()

                    # Split subtype into sub-subtype if applicable
                    subtype_parts = scheme_subtype.split(' - ')
                    if len(subtype_parts) > 1:
                        scheme_subtype = subtype_parts[0].strip()
                        scheme_subsubtype = subtype_parts[1].strip()
                    else:
                        scheme_subsubtype = ''

                    # Append to the lists
                    scheme_types.append(scheme_type)
                    scheme_subtypes.append(scheme_subtype)
                    scheme_subsubtypes.append(scheme_subsubtype)

# Create the "general" folder if it doesn't exist
output_folder = 'general'
os.makedirs(output_folder, exist_ok=True)

# Create a CSV file in the "general" folder from the extracted information
output_csv_path = os.path.join(output_folder, 'scheme_information.csv')
with open(output_csv_path, mode='w', newline='') as output_file:
    csv_writer = csv.writer(output_file)
    csv_writer.writerow(['Type of Scheme', 'Subtype', 'Subsubtype'])
    for scheme_info in zip(scheme_types, scheme_subtypes, scheme_subsubtypes):
        csv_writer.writerow(scheme_info)

print(f'CSV file "{output_csv_path}" created successfully in the "{output_folder}" folder.')
