# TestFlight Social Login Fix Checklist

## Current Issue
Social login (Google & Apple) works in Debug but fails in TestFlight builds.

## Your App Info
- **Bundle ID**: `com.mega-sun`
- **Team ID**: `N3R8MF955Y`
- **Firebase Project**: `megasun-riyada`

---

## ✅ Fix Checklist (Complete in Order)

### [ ] 1. Firebase Console - Download Complete GoogleService-Info.plist
1. Open: https://console.firebase.google.com/project/megasun-riyada/settings/general
2. Find iOS app: `com.mega-sun`
3. Download NEW `GoogleService-Info.plist`
4. Replace: `ios/Runner/GoogleService-Info.plist`
5. **IMPORTANT**: Open the file and copy the `REVERSED_CLIENT_ID` value

### [ ] 2. Update Info.plist with Google OAuth URL Scheme
1. Open: `ios/Runner/Info.plist`
2. Find line 77: `<string>com.googleusercontent.apps.YOUR-CLIENT-ID-HERE</string>`
3. Replace with the `REVERSED_CLIENT_ID` from GoogleService-Info.plist
4. Example: `<string>com.googleusercontent.apps.864507156762-abc123xyz</string>`

### [ ] 3. Apple Developer Console - Enable Sign in with Apple
1. Go to: https://developer.apple.com/account/resources/identifiers/list
2. Select App ID: `com.mega-sun`
3. Enable: ✅ **Sign in with Apple**
4. Save changes

### [ ] 4. Apple Developer Console - Regenerate Provisioning Profile
1. Go to: https://developer.apple.com/account/resources/profiles/list
2. Find: **App Store Distribution Profile** for `com.mega-sun`
3. **Delete old profile** (doesn't include Sign in with Apple)
4. **Create new profile**:
   - Type: App Store
   - App ID: com.mega-sun
   - Enable all capabilities (including Sign in with Apple)
   - Name: MegaSun AppStore Distribution
5. **Download** and double-click to install in Xcode

### [ ] 5. Google Cloud Console - Verify OAuth Client
1. Go to: https://console.cloud.google.com/apis/credentials?project=megasun-riyada
2. Find/Create: **iOS OAuth 2.0 Client ID**
3. Verify Bundle ID: `com.mega-sun`
4. If new, download updated GoogleService-Info.plist

### [ ] 6. Xcode - Verify Capabilities
1. Open: `ios/Runner.xcworkspace`
2. Select: Runner target
3. Tab: **Signing & Capabilities**
4. Change to **Release** configuration
5. Verify present: ✅ **Sign in with Apple**
6. Provisioning Profile: Select the NEW profile created in step 4

### [ ] 7. Clean Build and Test
```bash
cd /path/to/Mega-Sun
flutter clean
flutter pub get
flutter build ios --release
```

### [ ] 8. Upload to TestFlight
- Open Xcode
- Product → Archive
- Distribute App → App Store Connect
- Upload
- Test in TestFlight

---

## Common Issues

### Google Sign-In Still Fails
- **Check**: GoogleService-Info.plist has `REVERSED_CLIENT_ID`
- **Check**: Info.plist has the URL scheme from `REVERSED_CLIENT_ID`
- **Check**: Google Cloud Console OAuth client bundle ID matches exactly

### Apple Sign-In Still Fails
- **Check**: Runner.entitlements has `com.apple.developer.applesignin`
- **Check**: Apple Developer Console has capability enabled
- **Check**: Provisioning profile includes Sign in with Apple
- **Check**: Xcode is using the NEW provisioning profile

### Both Still Fail
- Try deleting the app from TestFlight device
- Re-download from TestFlight
- Check device logs in Console.app for errors

---

## Files Modified
- ✅ `ios/Runner/Runner.entitlements` - Added Apple Sign-In
- ⚠️ `ios/Runner/GoogleService-Info.plist` - **NEEDS REPLACEMENT**
- ⚠️ `ios/Runner/Info.plist` - **NEEDS GOOGLE URL SCHEME UPDATE**

## Status
- [x] Apple Sign-In entitlements fixed
- [ ] Google URL scheme needs REVERSED_CLIENT_ID
- [ ] Provisioning profile needs regeneration
- [ ] Apple Developer Console needs Sign in with Apple enabled
