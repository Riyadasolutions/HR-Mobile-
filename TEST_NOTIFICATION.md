# Test Notification for Points Added

## Notification Payload Format

To test the `pointsAdded` notification popup, send a Firebase Cloud Messaging notification with the following structure:

### Required Fields:
- `type`: Must be `"points_added"`
- `data`: JSON string containing:
  - `points` (optional): Number of points (defaults to 100)
  - `description` or `message` (optional): Message text

### Example Notification Payload:

```json
{
  "notification": {
    "title": "Points Added",
    "body": "You have earned 150 points!"
  },
  "data": {
    "type": "points_added",
    "id": "123",
    "data": "{\"points\": 150, \"description\": \"Your booking was successful! You have earned 150 new points.\"}"
  }
}
```

## Testing Methods:

### Method 1: Using Firebase Console
1. Go to Firebase Console → Cloud Messaging
2. Click "Send test message"
3. Enter your device FCM token (check app logs for "FCM token:")
4. In "Additional options" → "Custom data", add:
   - Key: `type`, Value: `points_added`
   - Key: `id`, Value: `123`
   - Key: `data`, Value: `{"points": 150, "description": "Test notification - You earned 150 points!"}`
5. Send the notification

### Method 2: Using cURL (Command Line)

Replace `YOUR_FCM_TOKEN` with your device token:

```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "YOUR_FCM_TOKEN",
    "notification": {
      "title": "Points Added",
      "body": "You have earned 150 points!"
    },
    "data": {
      "type": "points_added",
      "id": "123",
      "data": "{\"points\": 150, \"description\": \"Your booking was successful! You have earned 150 new points.\"}"
    }
  }'
```

### Method 3: Using Postman

1. Method: POST
2. URL: `https://fcm.googleapis.com/fcm/send`
3. Headers:
   - `Authorization`: `key=YOUR_SERVER_KEY`
   - `Content-Type`: `application/json`
4. Body (raw JSON):
```json
{
  "to": "YOUR_FCM_TOKEN",
  "notification": {
    "title": "Points Added",
    "body": "You have earned 150 points!"
  },
  "data": {
    "type": "points_added",
    "id": "123",
    "data": "{\"points\": 150, \"description\": \"Your booking was successful! You have earned 150 new points.\"}"
  }
}
```

### Method 4: Minimal Test (Default Values)

If you want to test with default values (100 points, default message):

```json
{
  "to": "YOUR_FCM_TOKEN",
  "notification": {
    "title": "Points Added",
    "body": "You have earned points!"
  },
  "data": {
    "type": "points_added",
    "id": "123"
  }
}
```

## Getting Your FCM Token

The app logs the FCM token when it's generated. Look for:
- Log tag: `FcmHandler`
- Message: `FCM token: <your_token>`

Or check the app console output when the app starts.

## Expected Behavior

When you receive a notification with `type: "points_added"`:
1. The popup dialog should appear automatically
2. It should show:
   - Points value (from data or default 100)
   - Message (from description/message or default success message)
3. Works in all scenarios:
   - App in foreground
   - App in background
   - App opened from notification
   - App opened from terminated state
