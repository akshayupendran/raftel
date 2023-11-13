import os
import csv
from datetime import datetime, timedelta
import requests
from io import StringIO

# Local directory to save the downloaded files
downloaded_files_directory = 'NAV'

# Ensure the directory exists, create it if not
os.makedirs(downloaded_files_directory, exist_ok=True)

# Function to convert a date string to the required format
def format_date(date_str):
    date_obj = datetime.strptime(date_str, '%d-%b-%Y')
    return date_obj.strftime('%Y%m%d')

# URL template
url_template = 'https://portal.amfiindia.com/DownloadNAVHistoryReport_Po.aspx?frmdt={}'

# Number of CSV files to download for one year
num_files_to_download = 365

# Find the last working weekday as the start date
current_date = datetime.now() - timedelta(days=1)  # Start from yesterday

for _ in range(num_files_to_download):
    # Format the current date in the required format
    formatted_date = format_date(current_date.strftime('%d-%b-%Y'))

    # Local file name for the CSV file
    local_file_name = f'{formatted_date}.csv'

    # Full path for the downloaded file
    downloaded_file_path = os.path.join(downloaded_files_directory, local_file_name)

    # Construct the URL for the current date
    url = url_template.format(formatted_date)

    # Check if the file already exists before making a request
    if os.path.exists(downloaded_file_path):
        print(f'The file {downloaded_file_path} already exists. Skipping.')
    else:
        # Fetching data from the URL
        response = requests.get(url)

        # Checking if the request was successful (status code 200)
        if response.status_code == 200:
            # Decoding the content of the response
            content = response.content.decode('utf-8')

            # Check if the downloaded content is a valid CSV file
            if content.startswith("Scheme Code;"):
                # Creating a CSV reader for the semicolon-separated content
                csv_reader = csv.reader(StringIO(content), delimiter=';')

                # Writing to CSV file locally
                with open(downloaded_file_path, mode='w', newline='') as file:
                    writer = csv.writer(file)

                    # Writing data rows
                    writer.writerows(csv_reader)

                print(f'CSV file "{local_file_name}" created successfully at {downloaded_file_path}.')
            else:
                print(f'Error: The content for {formatted_date} is not a valid CSV file.')
        else:
            print(f'Error: Unable to fetch data from {url}. Status code: {response.status_code}')

    # Move to the previous date
    current_date -= timedelta(days=1)
