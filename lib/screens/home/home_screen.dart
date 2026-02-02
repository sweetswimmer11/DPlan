import 'package:flutter/material.dart';
import 'package:d_plan/core/theme/app_colors.dart';
import 'package:d_plan/services/firebase_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService _firebaseService = FirebaseService();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, _firebaseService),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildFocusCard(),
                    const SizedBox(height: 16),
                    _buildStatsGrid(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Recent Notes', () {}),
                    const SizedBox(height: 12),
                    _buildRecentNotes(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Life Lists', () {}, showAction: false),
                    const SizedBox(height: 12),
                    _buildLifeListsSummary(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, FirebaseService _firebaseService) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2), width: 2),
              image: const DecorationImage(
                image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAoCVdJg3NlV3pWszdcTUMM1fESO0N81E3MT8kjsDou8f4LL5ZJ9lTIt71kvfR505E-pRAEQi_ykbOrp3t7mURvB1uOMvqO94TV1aUTxoQVhVEa1ChWNL9Y-ElMDHMiD7JmH1IFYN5sIEfMnStCTlBL7HZnr1K5RddFJsYfLcaraJysgSiatd5cI8zCRDB4E7WsxTueyqSNQbnBTcuzMiCL1WZzZ7yBscJP8PgiTfedRWh1uBJSaJOwdLdsASbpBCJ_P0WZ9gO8FM4"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning,',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Alex',
                  style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildIconButton(Icons.search),
              const SizedBox(width: 8),
              _buildIconButton(Icons.notifications_outlined),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () async {
                  await _firebaseService.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: _buildIconButton(Icons.logout),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.textDark),
    );
  }

  Widget _buildFocusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, color: AppColors.accentPurple, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        'FOCUS TIME',
                        style: TextStyle(
                          color: AppColors.accentPurple,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Deep Work Session',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Ready to start your 25min block',
                    style: TextStyle(color: AppColors.textGrey, fontSize: 14),
                  ),
                ],
              ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentPurple.withOpacity(0.1),
                  border: Border.all(color: AppColors.accentPurple.withOpacity(0.2), width: 4),
                ),
                child: const Center(
                  child: Text(
                    '25:00',
                    style: TextStyle(
                      color: AppColors.accentPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text('Start Session', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.assignment, color: AppColors.primaryBlue),
                    Text('+2 today', style: TextStyle(color: AppColors.successGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 12),
                Text('Pending Tasks', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text('5', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.checklist, color: AppColors.warningOrange),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.bgOrangeLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('60%', style: TextStyle(color: AppColors.warningOrange, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Checklist Items', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: '3 ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                      TextSpan(text: 'left', style: TextStyle(fontSize: 14, color: AppColors.textLightGrey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap, {bool showAction = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        if (showAction)
          TextButton(
            onPressed: onTap,
            child: const Text('View all', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }

  Widget _buildRecentNotes() {
    return Row(
      children: [
        _buildNoteCard('Project Apollo', 'Key points from the morning standup...', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAcEH-hjXXTaL1KnKaDSkvvhvoB6VdNtKqrLpApS0UVxP5i-ZBskg2VMJLdfos8E4I9NlUOyZAgksWsCEaUC2f_cCY-xPTVMkncX7I-FStTLwDnLlEx8HA1s2xcnX3NC9RmD1T4iS6H5UYWUq-H-4IPLj8D_vD1ROxsOky6EpRACPui6rU7t3u7CC1GNGRP1KzFrKWuQEeugFcJZeDsAQZ8WNKl52mimZjaI4yJRIR0ET-F4m0AwmooIs3ApK9xm0U88FnV4Pjez5Q'),
        const SizedBox(width: 12),
        _buildNoteCard('Ideas 2024', 'Exploring new vertical layouts for apps...', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDqsdbHAIYexhU5LOPVNYShW4jTcGFVIdFN001YHuxEdxL-R5zi2vhfJe3u5CBd5GpzgqC7yzeUGL54vnfRBXuH4a8nceTRb69onIAeqEu7GXHxRf1HpYF-LEDR68ffyaOH_DdmtB3-i5RLF5G805yMR-skaNskdiRpbQLD5_jaw-cGpBR4glvscM953HNitRo1PUyAW-t3K_c2cQaWt_A4ieCizgMMYbNMmWeGB7S6ZA4G7DbC4cg6YlFhTskdOx44FcI2qLfpQGo'),
      ],
    );
  }

  Widget _buildNoteCard(String title, String desc, String imageUrl) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(color: AppColors.textGrey, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildLifeListsSummary() {
    return Row(
      children: [
        _buildListSummaryCard(Icons.menu_book, 'Books', '12 items', Colors.pink),
        const SizedBox(width: 16),
        _buildListSummaryCard(Icons.movie, 'Movies', '45 items', Colors.indigo),
      ],
    );
  }

  Widget _buildListSummaryCard(IconData icon, String title, String subtitle, MaterialColor color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color[600], size: 24),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
