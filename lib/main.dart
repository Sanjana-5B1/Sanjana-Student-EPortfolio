import 'package:flutter/material.dart';

void main() => runApp(const SanjanaPortfolioApp());

const navy = Color(0xFF10172A);
const panel = Color(0xFF1B2540);
const violet = Color(0xFF8B7CFF);
const cyan = Color(0xFF62D9E8);

class SanjanaPortfolioApp extends StatelessWidget {
  const SanjanaPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanjana | E-Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navy,
        colorScheme: ColorScheme.fromSeed(seedColor: violet, brightness: Brightness.dark),
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: panel,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: violet)),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final email = TextEditingController();
  final password = TextEditingController();
  bool hidePassword = true;
  late final AnimationController animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..forward();

  @override
  void dispose() { email.dispose(); password.dispose(); animation.dispose(); super.dispose(); }

  void login() {
    if (email.text.trim().isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter your email and password to continue.')));
      return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const PortfolioDashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF202B4B), navy, Color(0xFF241D48)])),
      child: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 430), child: FadeTransition(
        opacity: animation,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 16),
          Center(child: Container(width: 112, height: 112, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: cyan, width: 3), boxShadow: [BoxShadow(color: violet.withOpacity(.25), blurRadius: 28)]), child: const CircleAvatar(backgroundColor: panel, child: Text('SP', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: cyan))))),
          const SizedBox(height: 24),
          const Text('Hello, welcome!', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('SANJANA PENCHALA  •  STUDENT PORTFOLIO', textAlign: TextAlign.center, style: TextStyle(color: cyan, letterSpacing: 1.2, fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 34),
          const Text('Sign in to explore my journey', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 15)),
          const SizedBox(height: 22),
          TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined), labelText: 'Email address', hintText: 'you@example.com')),
          const SizedBox(height: 15),
          TextField(controller: password, obscureText: hidePassword, onSubmitted: (_) => login(), decoration: InputDecoration(prefixIcon: const Icon(Icons.lock_outline), labelText: 'Password', suffixIcon: IconButton(icon: Icon(hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined), onPressed: () => setState(() => hidePassword = !hidePassword)))),
          const SizedBox(height: 22),
          SizedBox(height: 52, child: FilledButton.icon(onPressed: login, icon: const Icon(Icons.arrow_forward_rounded), label: const Text('Enter Portfolio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))),
          const SizedBox(height: 18),
          const Text('UID LAB • FLUTTER E-PORTFOLIO', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 11, letterSpacing: 1.5)),
        ]),
      ))))),
    ));
  }
}

class PortfolioDashboard extends StatefulWidget {
  const PortfolioDashboard({super.key});
  @override
  State<PortfolioDashboard> createState() => _PortfolioDashboardState();
}

class _PortfolioDashboardState extends State<PortfolioDashboard> {
  int selected = 0;
  final titles = const ['About Me', 'Education', 'Skills', 'Projects', 'Achievements'];
  final icons = const [Icons.person_outline, Icons.school_outlined, Icons.code, Icons.folder_open_outlined, Icons.emoji_events_outlined];

  @override
  Widget build(BuildContext context) {
    final pages = [const AboutSection(), const EducationSection(), const SkillsSection(), const ProjectsSection(), const AchievementsSection()];
    return Scaffold(
      appBar: AppBar(title: const Text('SANJANA / PORTFOLIO', style: TextStyle(fontSize: 14, letterSpacing: 1.4, fontWeight: FontWeight.bold)), backgroundColor: navy, actions: [IconButton(tooltip: 'Log out', onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage())), icon: const Icon(Icons.logout))]),
      body: Column(children: [
        Container(height: 3, decoration: const BoxDecoration(gradient: LinearGradient(colors: [violet, cyan]))),
        Expanded(child: AnimatedSwitcher(duration: const Duration(milliseconds: 350), transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: SlideTransition(position: Tween<Offset>(begin: const Offset(.04, 0), end: Offset.zero).animate(animation), child: child)), child: KeyedSubtree(key: ValueKey(selected), child: pages[selected]))),
      ]),
      bottomNavigationBar: NavigationBar(backgroundColor: const Color(0xFF151E34), indicatorColor: violet.withOpacity(.22), selectedIndex: selected, onDestinationSelected: (i) => setState(() => selected = i), destinations: [for (var i = 0; i < titles.length; i++) NavigationDestination(icon: Icon(icons[i]), label: titles[i])]),
    );
  }
}

class PageBody extends StatelessWidget {
  final String eyebrow, title, subtitle;
  final Widget child;
  const PageBody({super.key, required this.eyebrow, required this.title, required this.subtitle, required this.child});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 30), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 850), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(eyebrow.toUpperCase(), style: const TextStyle(color: cyan, letterSpacing: 2, fontSize: 11, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, height: 1.15)), const SizedBox(height: 9), Text(subtitle, style: const TextStyle(color: Colors.white60, height: 1.5)), const SizedBox(height: 24), child]))));
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const GlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(18)});
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, padding: padding, decoration: BoxDecoration(color: panel.withOpacity(.78), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(.07))), child: child);
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) => PageBody(eyebrow: '01 / Introduction', title: 'A little about me.', subtitle: 'Computer science student • Curious learner • Problem solver', child: Column(children: [
    GlassCard(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 76, height: 76, decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(colors: [violet, cyan])), child: const Center(child: Text('SP', style: TextStyle(fontSize: 25, color: navy, fontWeight: FontWeight.w900)))), const SizedBox(width: 16), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Sanjana Penchala', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)), SizedBox(height: 5), Text('B.Tech student at BVRIT Hyderabad', style: TextStyle(color: cyan)), SizedBox(height: 8), Text('I enjoy building useful applications, exploring web technologies, and improving my problem-solving skills.', style: TextStyle(color: Colors.white70, height: 1.5))]))])),
    const SizedBox(height: 14),
    const Row(children: [Expanded(child: StatCard(value: '8.54', label: 'B.Tech CGPA')), SizedBox(width: 12), Expanded(child: StatCard(value: '97.3%', label: 'Intermediate')), SizedBox(width: 12), Expanded(child: StatCard(value: '3', label: 'Projects'))]),
    const SizedBox(height: 14), GlassCard(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Career focus', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), SizedBox(height: 8), Text('Strengthening Java, data structures, database concepts, and full-stack development while creating clean, user-friendly applications.', style: TextStyle(color: Colors.white70, height: 1.6))])),
    const SizedBox(height: 14), GlassCard(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Contact', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), SizedBox(height: 12), ContactLine(icon: Icons.email_outlined, text: 'pechalasanjana25@gmail.com'), ContactLine(icon: Icons.location_on_outlined, text: 'Hyderabad, Telangana'), ContactLine(icon: Icons.code, text: 'GitHub: sanjana-5b1')]))
  ]));
}

class StatCard extends StatelessWidget {
  final String value, label;
  const StatCard({super.key, required this.value, required this.label});
  @override
  Widget build(BuildContext context) => GlassCard(padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 8), child: Column(children: [FittedBox(child: Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: cyan))), const SizedBox(height: 5), Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white60, fontSize: 10))]));
}

class ContactLine extends StatelessWidget {
  final IconData icon; final String text;
  const ContactLine({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 9), child: Row(children: [Icon(icon, size: 18, color: cyan), const SizedBox(width: 10), Expanded(child: Text(text, style: const TextStyle(color: Colors.white70)))]));
}

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});
  @override
  Widget build(BuildContext context) => PageBody(eyebrow: '02 / Learning', title: 'Education.', subtitle: 'The milestones behind my learning journey.', child: Column(children: const [
    TimelineCard(icon: Icons.school, period: 'AUG 2024 — AUG 2028', title: 'B.Tech', place: 'BVRIT Hyderabad', detail: 'Hyderabad, India', score: 'CGPA 8.54'),
    SizedBox(height: 14), TimelineCard(icon: Icons.auto_stories, period: 'MAY 2022 — MAY 2024', title: 'Intermediate • MPC', place: 'Alphores Junior College', detail: 'Karimnagar, India', score: '97.3%'),
  ]));
}

class TimelineCard extends StatelessWidget {
  final IconData icon; final String period, title, place, detail, score;
  const TimelineCard({super.key, required this.icon, required this.period, required this.title, required this.place, required this.detail, required this.score});
  @override
  Widget build(BuildContext context) => GlassCard(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 46, height: 46, decoration: BoxDecoration(color: violet.withOpacity(.18), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: cyan)), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(period, style: const TextStyle(color: cyan, fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.bold)), const SizedBox(height: 7), Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(place, style: const TextStyle(color: Colors.white70)), Text(detail, style: const TextStyle(color: Colors.white38, fontSize: 12)), const SizedBox(height: 12), Align(alignment: Alignment.centerLeft, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7), decoration: BoxDecoration(color: violet.withOpacity(.18), borderRadius: BorderRadius.circular(30)), child: Text(score, style: const TextStyle(color: cyan, fontWeight: FontWeight.bold))))]))]));
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});
  @override
  Widget build(BuildContext context) => PageBody(eyebrow: '03 / Toolbox', title: 'Skills & tools.', subtitle: 'Technologies and concepts I have worked with.', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Programming languages', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), const SizedBox(height: 12), const Wrap(spacing: 9, runSpacing: 9, children: [SkillChip('Java'), SkillChip('Python'), SkillChip('C'), SkillChip('JavaScript')]),
    const SizedBox(height: 24), const Text('Web & database', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), const SizedBox(height: 12), const Wrap(spacing: 9, runSpacing: 9, children: [SkillChip('HTML'), SkillChip('CSS'), SkillChip('MySQL'), SkillChip('REST APIs'), SkillChip('Node.js'), SkillChip('Express')]),
    const SizedBox(height: 24), const Text('Core concepts', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), const SizedBox(height: 12), const Wrap(spacing: 9, runSpacing: 9, children: [SkillChip('Data Structures'), SkillChip('OOP'), SkillChip('DBMS'), SkillChip('Operating Systems'), SkillChip('Prompt Engineering')]),
    const SizedBox(height: 24), GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Current learning goal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)), const SizedBox(height: 8), const Text('Practising DSA in Java and building stronger foundations in software development.', style: TextStyle(color: Colors.white70)), const SizedBox(height: 15), ClipRRect(borderRadius: BorderRadius.circular(20), child: const LinearProgressIndicator(value: .65, minHeight: 7, color: cyan, backgroundColor: Color(0xFF34405B))), const SizedBox(height: 7), const Text('Learning is ongoing — progress indicator is illustrative.', style: TextStyle(color: Colors.white38, fontSize: 11))]))
  ]));
}

class SkillChip extends StatelessWidget {
  final String label; const SkillChip(this.label, {super.key});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(30), border: Border.all(color: violet.withOpacity(.35))), child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)));
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});
  @override
  Widget build(BuildContext context) => PageBody(eyebrow: '04 / What I build', title: 'Featured projects.', subtitle: 'Projects that helped me practise programming and application design.', child: Column(children: const [
    ProjectCard(number: '01', title: 'Smart User Explorer', tech: 'HTML • CSS • JavaScript • Node.js • REST API', description: 'Responsive user profile cards with a gender toggle, favourites, email copying, local storage, and a GitHub developer analyzer called GitPulse.', icon: Icons.people_alt_outlined),
    SizedBox(height: 14), ProjectCard(number: '02', title: 'Hostel Management System', tech: 'Java • Swing • OOP', description: 'Desktop application for student management, room allocation, availability tracking, multiple hostels, and waiting-list management.', icon: Icons.apartment_outlined),
    SizedBox(height: 14), ProjectCard(number: '03', title: 'Hangman', tech: 'C • Console I/O', description: 'Console word game with random word selection, letter guessing, hints, a dynamic hangman display, and replay functionality.', icon: Icons.videogame_asset_outlined),
  ]));
}

class ProjectCard extends StatelessWidget {
  final String number, title, tech, description; final IconData icon;
  const ProjectCard({super.key, required this.number, required this.title, required this.tech, required this.description, required this.icon});
  @override
  Widget build(BuildContext context) => GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(number, style: const TextStyle(color: cyan, fontWeight: FontWeight.bold)), const Spacer(), Icon(icon, color: violet, size: 25)]), const SizedBox(height: 10), Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(tech, style: const TextStyle(color: cyan, fontSize: 11, height: 1.5)), const SizedBox(height: 10), Text(description, style: const TextStyle(color: Colors.white70, height: 1.55))]));
}

class AchievementsSection extends StatefulWidget {
  const AchievementsSection({super.key});
  @override
  State<AchievementsSection> createState() => _AchievementsSectionState();
}

class _AchievementsSectionState extends State<AchievementsSection> {
  final controller = PageController(viewportFraction: .88);
  int page = 0;
  final certificates = const [
    CertificateData(title: 'Object Oriented Programming Through Java', issuer: 'CodeChef', date: '1 November 2025', asset: 'assets/certificates/java_oop.png', icon: Icons.workspace_premium),
    CertificateData(title: 'CS302PC: Data Structures', issuer: 'CodeChef', date: '28 November 2025', asset: 'assets/certificates/data_structures.png', icon: Icons.account_tree),
    CertificateData(title: 'LeetCode 100 Days Badge 2026', issuer: 'LeetCode', date: '2026', asset: 'assets/certificates/leetcode_100_days.png', icon: Icons.local_fire_department),
  ];
  @override
  void dispose() { controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => PageBody(eyebrow: '05 / Beyond the classroom', title: 'Achievements.', subtitle: 'Small milestones, consistent effort, and learning beyond coursework.', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    GlassCard(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Extracurricular activities', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)), SizedBox(height: 16), ActivityLine(icon: Icons.volunteer_activism, title: 'National Service Scheme (NSS)', detail: 'Volunteer at BVRIT Hyderabad • Dec 2024 – Present'), ActivityLine(icon: Icons.lightbulb_outline, title: 'Internal SIH Hackathon', detail: 'Participated in a campus innovation hackathon'), ActivityLine(icon: Icons.eco_outlined, title: '1M1B Green Skills Academy', detail: 'Participation in a green skills learning programme'), ActivityLine(icon: Icons.code, title: 'HackerRank Python', detail: '3-star Python rating') ])),
    const SizedBox(height: 25), Row(children: [const Expanded(child: Text('Certificate gallery', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),), Text('${page + 1} / ${certificates.length}', style: const TextStyle(color: cyan))]), const SizedBox(height: 12),
    SizedBox(
      height: 355,
      child: PageView.builder(
        controller: controller,
        itemCount: certificates.length,
        onPageChanged: (i) => setState(() => page = i),
        itemBuilder: (context, index) {
          final cert = certificates[index];
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              var scale = 1.0;
              if (controller.position.haveDimensions) {
                scale = (1 -
                        ((controller.page ?? controller.initialPage.toDouble()) - index)
                                .abs() *
                            .07)
                    .clamp(.92, 1.0);
              }
              return Transform.scale(scale: scale, child: child);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 5),
              child: GlassCard(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          cert.asset,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFF11182A),
                            child: Center(
                              child: Icon(cert.icon, size: 60, color: cyan),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cert.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${cert.issuer} • ${cert.date}',
                      style: const TextStyle(color: cyan, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
    const SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.center, children: [IconButton(onPressed: page > 0 ? () => controller.previousPage(duration: const Duration(milliseconds: 350), curve: Curves.easeOut) : null, icon: const Icon(Icons.arrow_back_ios_new)), const Text('Swipe to view certificates', style: TextStyle(color: Colors.white54, fontSize: 12)), IconButton(onPressed: page < certificates.length - 1 ? () => controller.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeOut) : null, icon: const Icon(Icons.arrow_forward_ios))]),
    const SizedBox(height: 14), GlassCard(child: const Row(children: [Icon(Icons.auto_awesome, color: cyan, size: 28), SizedBox(width: 12), Expanded(child: Text('Every certificate represents a step forward. I am always learning and building.', style: TextStyle(color: Colors.white70, height: 1.5)))]))
  ]));
}

class CertificateData {
  final String title, issuer, date, asset; final IconData icon;
  const CertificateData({required this.title, required this.issuer, required this.date, required this.asset, required this.icon});
}

class ActivityLine extends StatelessWidget {
  final IconData icon; final String title, detail;
  const ActivityLine({super.key, required this.icon, required this.title, required this.detail});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 38, height: 38, decoration: BoxDecoration(color: violet.withOpacity(.18), borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 20, color: cyan)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(detail, style: const TextStyle(color: Colors.white60, fontSize: 12, height: 1.4))]))]));
}
