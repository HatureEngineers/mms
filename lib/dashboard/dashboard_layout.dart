import 'package:flutter/material.dart';
import '../drawer/main_layout_fixedDrawer.dart';
import 'dashboard_buttons.dart';
import 'dashboard_items.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 1000;

    return MainLayout( // MainLayout ব্যবহার করা হয়েছে
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // বড় স্ক্রীনে DashboardButtons-এর ওপরে লোগো + টেক্সট
                    if (isLargeScreen)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/ic_launcher.png', // আপনার লোগোর পাথ দিন
                              height: 120,
                              width: 120,
                              errorBuilder: (context, error, stackTrace) {
                                return
                                  const Icon(
                                  Icons.mosque,
                                  size: 50,
                                );
                              },
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              'Hilltone International Islamic School & College',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 26.0),
                    // ✅ ড্যাশবোর্ড বাটন
                    const DashboardButtons(),

                    const SizedBox(height: 16.0),

                    // ✅ শিক্ষক, শিক্ষার্থী এবং অভিভাবকের কার্ডগুলো Row আকারে
                    buildTopCards(isLargeScreen),

                    const SizedBox(height: 16.0),

                    // ✅ GridView (ছাত্র-ছাত্রী অনুপাত, উপস্থিতি, ফি)
                    buildDashboardGrid(isLargeScreen),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
