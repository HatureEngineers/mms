import 'package:flutter/material.dart';
import '../academic/students_admission/admission.dart';
import '../accounts/bank/bank_page.dart';
import '../dashboard/dashboard_layout.dart';
import '../exam_management/pre_builds/management_page.dart';
import '../exam_management/questions/question_upload_page.dart';
import '../exam_management/seat_plan/seat_plan_page.dart';
import '../hostel_management/hostel_management_page.dart';
import '../hostel_management/room_seat/room_and_seat.dart';
import '../hostel_management/Guardian and Leave/guardian_and_leave.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "ড্যাশবোর্ড",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardLayout()),
              );
            },
          ),

          ExpansionTile(
            leading: const Icon(Icons.school, color: Colors.black),
            title: const Text(
              "একাডেমিক",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black, // 🔥 টেক্সট কালো করা হলো
              ),
            ),
            children: [
              _buildDrawerSubItem(
                text: "শিক্ষার্থী ভর্তি ফরম",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admission()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "শিক্ষার্থী",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admission()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "ক্লাস রুটিন",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admission()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "শিক্ষক/স্টাফ",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admission()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "লাইব্রেরী",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admission()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "খেলাধুলা",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admission()),
                  );
                },
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.house, color: Colors.black),
            title: const Text(
              "হোস্টেল",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black, // 🔥 টেক্সট কালো করা হলো
              ),
            ),
            children: [
              _buildDrawerSubItem(
                text: "হোস্টেল ভর্তি",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HostelManagementPage()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "রুম ও সিট",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.white,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3,  // প্রস্থ 3০%
                            maxHeight: MediaQuery.of(context).size.height * 0.51, // উচ্চতা 5০%
                          ),
                          child: RoomAndSeat(),
                        ),
                      );
                    },
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "অভিভাবক ও ছুটি",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GuardianAndLeave()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "বোডিং খরচ",
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Admission()),
                  // );
                },
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.note_alt_outlined, color: Colors.black),
            title: const Text(
              "পরীক্ষা ব্যবস্থাপনা",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black, // 🔥 টেক্সট কালো করা হলো
              ),
            ),
            children: [
              _buildDrawerSubItem(
                text: "সিট প্ল্যান",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SeatPlanPage()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "প্রশ্ন ব্যাংক",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuestionUploadPage()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "ফলাফল/রেজাল্ট",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admission()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "শিক্ষাবোর্ড",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admission()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "ব্যবস্থাপনা",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManagementPage()),
                  );
                },
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.account_balance_sharp, color: Colors.black),
            title: const Text(
              "একাউন্টস",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black, // 🔥 টেক্সট কালো করা হলো
              ),
            ),
            children: [
              _buildDrawerSubItem(
                text: "ভর্তি কার্যক্রম",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankPage()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "হোস্টেল/বোডিং",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankPage()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "বেতন ও বোনাস",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankPage()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "ব্যাংক লেনদেন",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankPage()),
                  );
                },
              ),
              _buildDrawerSubItem(
                text: "জমা ও খরচ",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankPage()),
                  );
                },
              ),
            ],
          ),

          _buildDrawerItem(
            icon: Icons.people_alt_outlined,
            text: "শিক্ষক/স্টাফ",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Admission()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: "সেটিংস",
            onTap: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),

          const SizedBox(height: 20),

          _buildDrawerItem(
            icon: Icons.logout,
            text: "Logout",
            color: Colors.redAccent,
            onTap: () {
              // লগ আউট করার জন্য ফাংশন
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // **Drawer Item Widget**
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color),
      ),
      hoverColor: Colors.blue[100],
      onTap: onTap,
    );
  }

  // **Drawer Sub-Item Widget (ExpansionTile-এর জন্য)**
  Widget _buildDrawerSubItem({
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 40), // সুন্দরভাবে ইনডেন্ট করা হয়েছে
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // আইটেমের কর্নার গোল করা
        ),
        tileColor: Colors.grey[100], // লাইট ব্যাকগ্রাউন্ড কালার
        leading: const Icon(Icons.arrow_right, color: Colors.blueAccent), // ছোট আইকন
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black, // সুন্দর কালার স্কিম
          ),
        ),
        hoverColor: Colors.blue[50], // হোভার করলে হালকা নীল রঙ দেখাবে
        onTap: onTap,
      ),
    );
  }
}
