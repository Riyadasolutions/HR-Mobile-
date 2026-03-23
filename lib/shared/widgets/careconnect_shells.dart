import 'package:flutter/material.dart';

import '../../theme/careconnect_theme.dart';

const careConnectPagePadding = EdgeInsets.symmetric(horizontal: 18, vertical: 14);
const careConnectSurfaceShadow = [
  BoxShadow(
    color: Color(0x12000000),
    blurRadius: 24,
    offset: Offset(0, 12),
  ),
];

class AuthPageScaffold extends StatelessWidget {
  const AuthPageScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.onBack,
  });

  final String title;
  final String subtitle;
  final Widget body;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: careConnectPagePadding.copyWith(bottom: 24),
          child: Column(
            children: [
              Row(
                children: [
                  HeaderCircleButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: onBack,
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 17,
                          color: CareConnectColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 14),
              const PageAccentLine(),
              const SizedBox(height: 18),
              body,
            ],
          ),
        ),
      ),
    );
  }
}

class StandalonePageScaffold extends StatelessWidget {
  const StandalonePageScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailingBadge,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final String? trailingBadge;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CareConnectColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: careConnectPagePadding.copyWith(bottom: 24),
          child: Column(
            children: [
              SimpleHeader(
                title: title,
                subtitle: subtitle,
                trailingBadge: trailingBadge,
                leadingAction: onBack,
              ),
              const SizedBox(height: 18),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleHeader extends StatelessWidget {
  const SimpleHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingBadge,
    this.leadingAction,
  });

  final String title;
  final String subtitle;
  final String? trailingBadge;
  final VoidCallback? leadingAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (leadingAction != null)
              HeaderCircleButton(icon: Icons.arrow_back_rounded, onTap: leadingAction!)
            else
              const SizedBox(width: 54),
            const Spacer(),
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 31, fontWeight: FontWeight.w800, height: 1),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 18, color: CareConnectColors.textSecondary),
                ),
              ],
            ),
            const Spacer(),
            if (trailingBadge != null)
              BadgePill(label: trailingBadge!)
            else
              const SizedBox(width: 54),
          ],
        ),
        const SizedBox(height: 14),
        const PageAccentLine(),
        const SizedBox(height: 18),
      ],
    );
  }
}

class PageAccentLine extends StatelessWidget {
  const PageAccentLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 4,
      decoration: BoxDecoration(
        color: CareConnectColors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class SectionSurface extends StatelessWidget {
  const SectionSurface({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: careConnectSurfaceShadow,
      ),
      child: child,
    );
  }
}

class BadgePill extends StatelessWidget {
  const BadgePill({super.key, required this.label, this.backgroundColor, this.textColor});

  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFEAF7F1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor ?? CareConnectColors.teal,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class MetricMiniCard extends StatelessWidget {
  const MetricMiniCard({
    super.key,
    required this.label,
    required this.value,
    required this.caption,
    this.valueColor,
    this.labelColor,
  });

  final String label;
  final String value;
  final String caption;
  final Color? valueColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: careConnectSurfaceShadow,
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: labelColor ?? CareConnectColors.textSecondary)),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              height: 1,
              fontWeight: FontWeight.w800,
              color: valueColor ?? CareConnectColors.tealDark,
            ),
          ),
          if (caption.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              caption,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: CareConnectColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }
}

class ChoicePill extends StatelessWidget {
  const ChoicePill({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: selected ? CareConnectColors.teal : const Color(0xFFF1F5FA),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? Colors.white : CareConnectColors.textPrimary, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : CareConnectColors.textPrimary,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldCard extends StatelessWidget {
  const TextFieldCard({
    super.key,
    required this.hintText,
    required this.icon,
    this.trailingIcon,
    this.obscureText = false,
  });

  final String hintText;
  final IconData icon;
  final IconData? trailingIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: CareConnectColors.textSecondary),
        suffixIcon: trailingIcon == null ? null : Icon(trailingIcon, color: CareConnectColors.textSecondary),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 18, color: CareConnectColors.textSecondary)),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class RowDivider extends StatelessWidget {
  const RowDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: CareConnectColors.border);
  }
}

class HeaderCircleButton extends StatelessWidget {
  const HeaderCircleButton({super.key, required this.icon, required this.onTap, this.badge = false});

  final IconData icon;
  final VoidCallback onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5F4),
              shape: BoxShape.circle,
              boxShadow: careConnectSurfaceShadow,
            ),
            child: Icon(icon, color: CareConnectColors.teal, size: 26),
          ),
        ),
        if (badge)
          Positioned(
            right: 3,
            top: 3,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(color: Color(0xFFE25C5A), shape: BoxShape.circle),
            ),
          ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor = CareConnectColors.teal,
    this.textColor = Colors.white,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class SecondaryActionButton extends StatelessWidget {
  const SecondaryActionButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: CareConnectColors.textPrimary,
          side: const BorderSide(color: CareConnectColors.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}

class ActionPill extends StatelessWidget {
  const ActionPill({super.key, required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        backgroundColor: Colors.white,
        foregroundColor: CareConnectColors.textPrimary,
        side: const BorderSide(color: CareConnectColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontSize: 17)),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: careConnectSurfaceShadow,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded, color: CareConnectColors.textSecondary),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class StatusOutlineCard extends StatelessWidget {
  const StatusOutlineCard({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE9FAF5),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: CareConnectColors.teal, width: 1.6),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline_rounded, color: CareConnectColors.teal, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(fontSize: 17, color: CareConnectColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBanner extends StatelessWidget {
  const StatusBanner({super.key, required this.label, required this.title, required this.trailing});

  final String label;
  final String title;
  final IconData trailing;

  @override
  Widget build(BuildContext context) {
    return SectionSurface(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  letterSpacing: 4,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: CareConnectColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            ],
          ),
          const Spacer(),
          Icon(trailing, color: CareConnectColors.teal, size: 34),
        ],
      ),
    );
  }
}
