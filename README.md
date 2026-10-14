# IT Help Desk

The React frontend and Spring Boot backend can be started together on Windows.

## Start both applications

1. Make sure MySQL is running and the `helpdesk_db` database exists. The backend connection settings are in `helpdesk-backend\helpdesk-backend\src\main\resources\application.properties`.
2. Open PowerShell in this project folder and run:

   ```powershell
   .\start-helpdesk.ps1
   ```

The script opens a terminal for each server. Open the frontend at <http://localhost:5173>; it forwards `/api` requests to the backend at <http://localhost:8080>.

On the first run, install frontend dependencies with `npm install` from `helpdesk-frontend` if they are not already installed. Keep both server terminals open while using the application.
