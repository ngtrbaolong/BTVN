import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Default profile information
  String name = 'Bảo Long';
  String location = 'HCM, VN';

  void _showEditDialog() {
    // Controllers for text fields with current values
    final nameController = TextEditingController(text: name);
    final locationController = TextEditingController(text: location);

    // Get screen size for responsive dialog sizing
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    // Show responsive dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Responsive width for the dialog
        contentPadding: EdgeInsets.all(screenSize.width * 0.04),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: screenSize.width * (isSmallScreen ? 0.8 : 0.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: isSmallScreen ? 12 : 16,
                    ),
                  ),
                  style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: isSmallScreen ? 12 : 16,
                    ),
                  ),
                  style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Update state with new values
              setState(() {
                name = nameController.text;
                location = locationController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical: isSmallScreen ? 8 : 12,
              ),
            ),
            child: Text(
              'Save',
              style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive calculations
    final Size screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    // Screen size based calculations
    final bool isSmallScreen = screenSize.width < 600;
    final bool isTablet = screenSize.width >= 600 && screenSize.width < 900;
    final bool isLandscape = orientation == Orientation.landscape;

    // Dynamic sizing based on device type and orientation
    final double avatarSizePercent = isLandscape ? 0.20 : 0.28;
    final double maxAvatarSize = isTablet ? 160.0 : 140.0;
    final double avatarSize = screenSize.width * avatarSizePercent;
    final double actualAvatarSize = avatarSize > maxAvatarSize ? maxAvatarSize : avatarSize;

    // Text sizes adapted to different devices
    final double nameFontSize = isSmallScreen
        ? screenSize.width * 0.06
        : (isTablet ? screenSize.width * 0.05 : screenSize.width * 0.04);

    final double locationFontSize = isSmallScreen
        ? screenSize.width * 0.04
        : (isTablet ? screenSize.width * 0.03 : screenSize.width * 0.025);

    // Icon sizes
    final double iconSize = isSmallScreen ? 24 : 28;

    // Spacing
    final double verticalSpacing = screenSize.height * (isLandscape ? 0.02 : 0.03);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // App bar section with responsive padding
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.height * (isLandscape ? 0.015 : 0.02),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black54),
                          onPressed: () {},
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                          constraints: BoxConstraints(),
                          iconSize: iconSize,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: _showEditDialog,
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                          constraints: BoxConstraints(),
                          iconSize: iconSize,
                        ),
                      ),
                    ],
                  ),
                ),

                // Expanded section - adapts to landscape/portrait
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                          vertical: isLandscape ? 0 : screenSize.height * 0.02,
                        ),
                        child: isLandscape
                        // Landscape layout - horizontal arrangement
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile image
                            Container(
                              width: actualAvatarSize,
                              height: actualAvatarSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: isSmallScreen ? 1 : 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(actualAvatarSize / 2),
                                child: Image.asset(
                                  'assets/codontrensofa.jpg',
                                  width: actualAvatarSize,
                                  height: actualAvatarSize,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: screenSize.width * 0.05),

                            // Name and location
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: nameFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: verticalSpacing * 0.5),
                                Text(
                                  location,
                                  style: TextStyle(
                                    fontSize: locationFontSize,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                        // Portrait layout - vertical arrangement
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile Image with responsive size
                            Container(
                              width: actualAvatarSize,
                              height: actualAvatarSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: isSmallScreen ? 1 : 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(actualAvatarSize / 2),
                                child: Image.asset(
                                  'assets/codontrensofa.jpg',
                                  width: actualAvatarSize,
                                  height: actualAvatarSize,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: verticalSpacing),

                            // Name with responsive font size
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: nameFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: verticalSpacing * 0.5),

                            // Location with responsive font size
                            Text(
                              location,
                              style: TextStyle(
                                fontSize: locationFontSize,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}