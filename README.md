
# eRide Diagnostics

## Overview
eRide Diagnostics is an application designed to monitor and diagnose eBike performance. It allows users to connect their eBikes, view real-time status (e.g., battery charge, motor RPM), and fetch detailed model information from the cloud.

## Features
- **Scan for eBikes**: The app scans and discovers available eBikes (via USB and BLE).
- **Connect and View Data**: After connecting, it displays real-time data, including bike status, battery, motor RPM, and more.
- **Model Information**: Fetches and displays bike model info from a mock JSON server (images and descriptions).
- **Analytics**: Simulates "Bike Connected" events for analytics tracking (logged in the console).
  
## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repo-url>
   cd eRide-Diagnostics
   ```

2. **Install Dependencies**
   Run the following to install required packages:
   ```bash
   flutter pub get
   ```

3. **Set Up JSON Server** (for model information[Optional])
   - To run the mock JSON server that provides bike model data, you need to install and run it locally. However, this step is optional, as the app can fetch model information from local mock data as well.
   
   - Install **JSON Server**:
     ```bash
     npm install -g json-server
     ```
   
   - Navigate to the `assets/mock_server` directory in the project:
     ```bash
     cd assets/mock_server
     ```
   
   - Start the JSON server:
     ```bash
     json-server --watch db.json --port 3000
     ```
   
   The server will be accessible at `http://localhost:3000`.

4. **Run the App**
   Finally, launch the Flutter app:
   ```bash
   flutter run
   ```

## Assumptions & Notes
- The application simulates eBike connections (USB/BLE) via mock data.
- Real devices or backend APIs are not required for testing. Instead, mock data from JSON files and a mock server are used.
- BLE Connection Service: The BLE connection service has been added as a part of the app, but it is not functional at the moment. It can be enabled and tested once the actual BLE hardware is available.
- The analytics tracking feature is simulated, with connection events logged to the console.

## Evaluations
- The app demonstrates the ability to connect to and interact with eBikes, display real-time data, and fetch model information.
- While actual hardware isn't present, the app works with mock data and a local JSON server to simulate full functionality.
