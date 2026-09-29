import 'package:flutter/material.dart';

void main() => runApp(const ClimLabApp());

class ClimLabApp extends StatelessWidget {
  const ClimLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClimLab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B7285)),
        scaffoldBackgroundColor: const Color(0xFFF4F7F7),
        fontFamily: 'Avenir',
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedLevel = 'Tous les niveaux';
  int selectedNavigation = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 900;
        return Scaffold(
          drawer: compact ? _buildDrawer(context) : null,
          body: Row(
            children: [
              if (!compact) _buildSidebar(context),
              Expanded(child: _buildContent(context, compact)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, bool compact) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildTopBar(context, compact)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(32, 20, 32, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildWelcome(context),
                const SizedBox(height: 28),
                _buildStats(),
                const SizedBox(height: 28),
                _buildContinueCard(),
                const SizedBox(height: 32),
                _buildSectionHeader(),
                const SizedBox(height: 16),
                _buildModuleGrid(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool compact) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
      child: Row(
        children: [
          if (compact)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            tooltip: 'Notifications',
            icon: const Badge(
              smallSize: 7,
              backgroundColor: Color(0xFFE76F51),
              child: Icon(Icons.notifications_none_rounded),
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 19,
            backgroundColor: Color(0xFFFFD166),
            child: Text(
              'LM',
              style: TextStyle(
                color: Color(0xFF27303B),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (!compact) ...[
            const SizedBox(width: 10),
            const Text(
              'Léa Martin',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) => Container(
    width: 248,
    color: const Color(0xFF102A35),
    child: _sidebarContent(context),
  );

  Widget _buildDrawer(BuildContext context) => Drawer(
    backgroundColor: const Color(0xFF102A35),
    child: _sidebarContent(context),
  );

  Widget _sidebarContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 44),
              child: Row(
                children: [
                  Icon(
                    Icons.ac_unit_rounded,
                    color: Color(0xFF65D2C5),
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'ClimLab',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, bottom: 12),
              child: Text(
                'ESPACE APPRENANT',
                style: TextStyle(
                  color: Color(0xFF7D9BA3),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            _navItem(Icons.grid_view_rounded, "Vue d'ensemble", 0),
            _navItem(Icons.menu_book_rounded, 'Mes cours', 1),
            _navItem(Icons.fact_check_outlined, 'Évaluations', 2),
            _navItem(Icons.bar_chart_rounded, 'Ma progression', 3),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A3C48),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    color: Color(0xFFFFD166),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Besoin d'un coup de main ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Retrouve les fiches méthode dans ton espace.',
                    style: TextStyle(
                      color: Color(0xFFB5C9CC),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _navItem(Icons.settings_outlined, 'Paramètres', 4),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final selected = selectedNavigation == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          selected: selected,
          selectedTileColor: const Color(0xFF24515A),
          leading: Icon(
            icon,
            color: selected ? const Color(0xFF65D2C5) : const Color(0xFF8DA7AC),
            size: 21,
          ),
          title: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFFB5C9CC),
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
          onTap: () => setState(() => selectedNavigation = index),
        ),
      ),
    );
  }

  Widget _buildWelcome(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'LUNDI 21 SEPTEMBRE 2026',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Bonjour Léa,',
        style: TextStyle(
          color: Color(0xFF102A35),
          fontSize: 32,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 6),
      const Text(
        'Prête à faire monter tes compétences d’un degré ?',
        style: TextStyle(color: Color(0xFF64777D), fontSize: 15),
      ),
    ],
  );

  Widget _buildStats() => const Wrap(
    spacing: 16,
    runSpacing: 16,
    children: [
      _StatCard(
        icon: Icons.local_fire_department_rounded,
        value: '7',
        label: 'jours de série',
        color: Color(0xFFE76F51),
      ),
      _StatCard(
        icon: Icons.check_circle_outline_rounded,
        value: '68%',
        label: 'cours terminés',
        color: Color(0xFF2A9D8F),
      ),
      _StatCard(
        icon: Icons.bolt_rounded,
        value: '420',
        label: 'points gagnés',
        color: Color(0xFFE9B949),
      ),
    ],
  );

  Widget _buildContinueCard() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: const Color(0xFF1E5961),
      borderRadius: BorderRadius.circular(12),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 500;
        return Flex(
          direction: compact ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: compact ? 0 : 3,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'À REPRENDRE',
                    style: TextStyle(
                      color: Color(0xFF9CE2D8),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Les bases du cycle frigorifique',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Chapitre 2  •  12 min restantes',
                    style: TextStyle(color: Color(0xFFC4E4E0), fontSize: 13),
                  ),
                ],
              ),
            ),
            if (compact) const SizedBox(height: 20),
            Expanded(
              flex: compact ? 0 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PROGRESSION',
                    style: TextStyle(
                      color: Color(0xFF9CE2D8),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '75%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '3 / 4',
                        style: TextStyle(
                          color: Color(0xFFC4E4E0),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: .75,
                      minHeight: 8,
                      backgroundColor: Color(0xFF38777D),
                      color: Color(0xFFFFD166),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow_rounded, size: 19),
                      label: const Text('Continuer'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD166),
                        foregroundColor: const Color(0xFF102A35),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  Widget _buildSectionHeader() {
    final levels = [
      'Tous les niveaux',
      'Seconde',
      'Première',
      'Terminale',
      'BTS MSF',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explorer les modules',
          style: TextStyle(
            color: Color(0xFF102A35),
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: levels
                .map(
                  (level) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(level),
                      selected: selectedLevel == level,
                      onSelected: (_) => setState(() => selectedLevel = level),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildModuleGrid() {
    final modules = [
      (
        'Thermodynamique',
        'Comprendre les échanges de chaleur',
        Icons.device_thermostat_rounded,
        const Color(0xFFE76F51),
        '4 chapitres',
      ),
      (
        'Électricité',
        'Mesurer et protéger une installation',
        Icons.electrical_services_rounded,
        const Color(0xFFE9B949),
        '6 chapitres',
      ),
      (
        'Hydraulique',
        'Les fluides en mouvement',
        Icons.water_drop_outlined,
        const Color(0xFF3A86FF),
        '3 chapitres',
      ),
      (
        'Régulation',
        'Piloter la température et la pression',
        Icons.tune_rounded,
        const Color(0xFF7B61A8),
        '5 chapitres',
      ),
      (
        'Technologie',
        'Identifier les équipements et leurs fonctions',
        Icons.precision_manufacturing_rounded,
        const Color(0xFF2A9D8F),
        '4 chapitres',
      ),
      (
        'Maintenance préventive',
        'Anticiper les pannes et entretenir les systèmes',
        Icons.build_circle_outlined,
        const Color(0xFFBC6C25),
        '5 chapitres',
      ),
      (
        'Maintenance corrective',
        'Diagnostiquer et remettre en service',
        Icons.handyman_outlined,
        const Color(0xFFD1495B),
        '4 chapitres',
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 900
            ? 4
            : constraints.maxWidth > 560
            ? 2
            : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: modules.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: columns == 1 ? 2.1 : 1.18,
          ),
          itemBuilder: (context, index) {
            final module = modules[index];
            return _ModuleCard(
              title: module.$1,
              subtitle: module.$2,
              icon: module.$3,
              color: module.$4,
              chapters: module.$5,
              selected: selectedLevel,
              onTap: module.$1 == 'Thermodynamique'
                  ? () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ThermodynamicsChapterPage(),
                      ),
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 190,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE1E9E8)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .13),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF102A35),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF708187),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.chapters,
    required this.selected,
    this.onTap,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String chapters;
  final String selected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE1E9E8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .13),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color),
                ),
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 19,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF102A35),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF708187),
                fontSize: 12,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Text(
                    chapters,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    selected == 'Tous les niveaux' ? 'Tous niveaux' : selected,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Color(0xFF89979B),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class ThermodynamicsChapterPage extends StatefulWidget {
  const ThermodynamicsChapterPage({super.key});

  @override
  State<ThermodynamicsChapterPage> createState() =>
      _ThermodynamicsChapterPageState();
}

class _ThermodynamicsChapterPageState extends State<ThermodynamicsChapterPage> {
  final Map<int, int> _answers = {};
  bool _isCompleted = false;

  static const _questions = <(String, List<String>, int, String)>[
    (
      'Une boisson à 60 °C et une autre à 20 °C sont mises en contact. Dans quel sens l’énergie thermique se transfère-t-elle spontanément ?',
      [
        'De 60 °C vers 20 °C',
        'De 20 °C vers 60 °C',
        'Dans les deux sens de façon équilibrée',
      ],
      0,
      'L’énergie thermique se transfère spontanément du corps le plus chaud vers le plus froid.',
    ),
    (
      'Une cuillère métallique chauffe dans une soupe chaude. Quel mode de transfert domine le long de la cuillère ?',
      ['La conduction', 'La convection', 'Le rayonnement'],
      0,
      'La conduction transmet l’énergie à travers la matière, sans déplacement global du solide.',
    ),
    (
      'Pourquoi l’air réchauffé près d’un radiateur a-t-il tendance à monter ?',
      [
        'Il devient moins dense et se déplace',
        'Il conduit mieux la chaleur',
        'Il émet davantage de lumière visible',
      ],
      0,
      'L’air chaud, moins dense, monte tandis que l’air plus frais descend : c’est un mouvement de convection.',
    ),
  ];

  int get _score => _answers.entries
      .where((entry) => _questions[entry.key].$3 == entry.value)
      .length;
  bool get _allCorrect =>
      _answers.length == _questions.length && _score == _questions.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          tooltip: 'Retour aux cours',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'THERMODYNAMIQUE',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                'SECONDE',
                style: TextStyle(
                  color: Color(0xFF1E5961),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 880;
            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: narrow ? 20 : 40,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildChapterHeader(),
                        const SizedBox(height: 30),
                        if (narrow) ...[
                          _buildLessonContent(),
                          const SizedBox(height: 24),
                          _buildKeyPoints(),
                        ] else
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 7, child: _buildLessonContent()),
                              const SizedBox(width: 28),
                              Expanded(flex: 3, child: _buildKeyPoints()),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChapterHeader() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'MODULE 01  /  CHAPITRE 01',
        style: TextStyle(
          color: Color(0xFF1E5961),
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Température, chaleur et transferts thermiques',
        style: TextStyle(
          color: Color(0xFF102A35),
          fontSize: 30,
          height: 1.15,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Les bases pour comprendre comment l’énergie circule dans les systèmes de chauffage et de froid.',
        style: TextStyle(color: Color(0xFF64777D), fontSize: 15, height: 1.5),
      ),
      const SizedBox(height: 16),
      const Wrap(
        spacing: 18,
        runSpacing: 8,
        children: [
          _MetadataItem(icon: Icons.schedule_rounded, label: '15 min'),
          _MetadataItem(
            icon: Icons.menu_book_rounded,
            label: 'Notions essentielles',
          ),
          _MetadataItem(icon: Icons.quiz_outlined, label: '3 questions'),
        ],
      ),
    ],
  );

  Widget _buildLessonContent() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ChapterSection(
        number: '01',
        title: 'La température décrit un état',
        children: const [
          Text(
            'La température indique si un objet est chaud ou froid. À l’échelle microscopique, elle est liée à l’agitation de ses particules : plus elles s’agitent, plus la température est élevée.',
            style: _lessonTextStyle,
          ),
          SizedBox(height: 10),
          Text(
            'On la mesure avec un thermomètre. Dans ce cours, on utilise principalement le degré Celsius (°C). Deux objets à la même température sont en équilibre thermique : aucun transfert net de chaleur ne se produit entre eux.',
            style: _lessonTextStyle,
          ),
        ],
      ),
      _ChapterSection(
        number: '02',
        title: 'La chaleur est une énergie en transfert',
        children: const [
          Text(
            'La chaleur n’est pas la température : c’est un transfert d’énergie thermique entre des objets qui n’ont pas la même température. Sans intervention extérieure, ce transfert se fait du plus chaud vers le plus froid.',
            style: _lessonTextStyle,
          ),
          SizedBox(height: 10),
          Text(
            'Ce transfert continue jusqu’à ce que les objets atteignent la même température. L’énergie se mesure en joules (J).',
            style: _lessonTextStyle,
          ),
        ],
      ),
      _ChapterSection(
        number: '03',
        title: 'Trois modes de transfert thermique',
        children: const [
          _TransferRow(
            icon: Icons.linear_scale_rounded,
            color: Color(0xFFE76F51),
            title: 'Conduction',
            description: 'L’énergie se transmet de proche en proche dans un matériau, sans déplacement global de celui-ci. Exemple : une cuillère métallique plongée dans une boisson chaude.',
          ),
          Divider(height: 22, color: Color(0xFFE1E9E8)),
          _TransferRow(
            icon: Icons.air_rounded,
            color: Color(0xFF3A86FF),
            title: 'Convection',
            description: 'La chaleur est transportée par le mouvement d’un fluide, comme l’air ou l’eau. Exemple : l’air réchauffé par un radiateur monte dans la pièce.',
          ),
          Divider(height: 22, color: Color(0xFFE1E9E8)),
          _TransferRow(
            icon: Icons.wb_sunny_outlined,
            color: Color(0xFFE9B949),
            title: 'Rayonnement',
            description: 'L’énergie est transportée par des ondes électromagnétiques, même dans le vide. Exemple : la chaleur du Soleil atteint la Terre.',
          ),
        ],
      ),
      _buildRefrigeratorExample(),
      _buildQuiz(),
    ],
  );

  Widget _buildRefrigeratorExample() => Container(
    margin: const EdgeInsets.only(bottom: 22),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF102A35),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Row(
          children: [
            Icon(Icons.ac_unit_rounded, color: Color(0xFF65D2C5), size: 20),
            SizedBox(width: 9),
            Text(
              'APPLICATION CVC',
              style: TextStyle(
                color: Color(0xFF9CE2D8),
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Où va la chaleur dans un réfrigérateur ?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Le réfrigérateur prélève de l’énergie thermique à l’intérieur, au niveau de l’évaporateur, puis la rejette dans la pièce par le condenseur. La pièce reçoit donc de la chaleur, même si l’intérieur du réfrigérateur refroidit.',
          style: TextStyle(
            color: Color(0xFFD4E2E3),
            fontSize: 13,
            height: 1.55,
          ),
        ),
      ],
    ),
  );

  Widget _buildKeyPoints() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFE4F2EF),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'À RETENIR',
          style: TextStyle(
            color: Color(0xFF1E5961),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 15),
        _KeyPoint(text: 'La température se mesure en degrés Celsius (°C).'),
        _KeyPoint(
          text: 'La chaleur est un transfert d’énergie thermique, mesuré en joules (J).',
        ),
        _KeyPoint(text: 'Le transfert spontané va du chaud vers le froid.'),
        _KeyPoint(
          text: 'Les trois modes sont la conduction, la convection et le rayonnement.',
        ),
      ],
    ),
  );

  Widget _buildQuiz() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE1E9E8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'VÉRIFIE TES REPÈRES',
          style: TextStyle(
            color: Color(0xFF1E5961),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          '$_score / ${_questions.length} bonne${_score == 1 ? '' : 's'} réponse${_score == 1 ? '' : 's'}',
          style: const TextStyle(color: Color(0xFF64777D), fontSize: 13),
        ),
        const SizedBox(height: 12),
        for (
          var questionIndex = 0;
          questionIndex < _questions.length;
          questionIndex++
        )
          _buildQuestion(questionIndex),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _allCorrect && !_isCompleted
                ? () {
                    setState(() => _isCompleted = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Chapitre 1 terminé. Bravo !'),
                      ),
                    );
                  }
                : null,
            icon: Icon(
              _isCompleted
                  ? Icons.check_circle_outline_rounded
                  : Icons.flag_outlined,
              size: 18,
            ),
            label: Text(
              _isCompleted ? 'Chapitre terminé' : 'Valider le chapitre',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF1E5961),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 13),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildQuestion(int questionIndex) {
    final question = _questions[questionIndex];
    final selectedAnswer = _answers[questionIndex];
    final answeredCorrectly = selectedAnswer == question.$3;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${questionIndex + 1}. ${question.$1}',
            style: const TextStyle(
              color: Color(0xFF102A35),
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (
                var optionIndex = 0;
                optionIndex < question.$2.length;
                optionIndex++
              )
                ChoiceChip(
                  label: Text(question.$2[optionIndex]),
                  selected: selectedAnswer == optionIndex,
                  onSelected: _isCompleted
                      ? null
                      : (_) => setState(
                          () => _answers[questionIndex] = optionIndex,
                        ),
                  selectedColor:
                      selectedAnswer == optionIndex && answeredCorrectly
                      ? const Color(0xFFD8EFE8)
                      : null,
                ),
            ],
          ),
          if (selectedAnswer != null) ...[
            const SizedBox(height: 5),
            Text(
              answeredCorrectly ? question.$4 : 'Pas tout à fait. Relis la notion, puis essaie une autre réponse.',
              style: TextStyle(
                color: answeredCorrectly
                    ? const Color(0xFF21735E)
                    : const Color(0xFFB6523C),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ChapterSection extends StatelessWidget {
  const _ChapterSection({
    required this.number,
    required this.title,
    required this.children,
  });

  final String number;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFE4F2EF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFF1E5961),
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF102A35),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              ...children,
            ],
          ),
        ),
      ],
    ),
  );
}

class _TransferRow extends StatelessWidget {
  const _TransferRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: color, size: 21),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(description, style: _lessonTextStyle),
          ],
        ),
      ),
    ],
  );
}

class _MetadataItem extends StatelessWidget {
  const _MetadataItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: const Color(0xFF708187), size: 16),
      const SizedBox(width: 6),
      Text(
        label,
        style: const TextStyle(color: Color(0xFF708187), fontSize: 12),
      ),
    ],
  );
}

class _KeyPoint extends StatelessWidget {
  const _KeyPoint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.check_rounded, color: Color(0xFF2A9D8F), size: 17),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF334D53),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

const _lessonTextStyle = TextStyle(
  color: Color(0xFF52666D),
  fontSize: 14,
  height: 1.55,
);
