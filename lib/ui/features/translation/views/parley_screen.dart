import 'package:flutter/material.dart';
import 'package:parley_app/core/constants/app_constants.dart';
import 'package:parley_app/core/theme/app_theme.dart';
import '../view_models/translation_view_model.dart';
import '../widgets/animate_in_effect.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/listening_indicator.dart';
import '../widgets/mic_button.dart';

/// Tela principal interativa para tradução simultânea voz-para-voz.
class ParleyScreen extends StatefulWidget {
  const ParleyScreen({super.key});

  @override
  State<ParleyScreen> createState() => _ParleyScreenState();
}

class _ParleyScreenState extends State<ParleyScreen> {
  late final TranslationViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = TranslationViewModel();
    _viewModel.initialize();
    _viewModel.onScrollToBottomRequested = _scrollToBottom;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        final isListening = _viewModel.isListening;
        final conversation = _viewModel.conversation;

        return Scaffold(
          backgroundColor: AppTheme.surface,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            backgroundColor: AppTheme.surface,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.logoIcon,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.forum,
                      size: 32,
                      color: colorScheme.primary,
                    );
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  'Parley',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            actions: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _viewModel.autoPlayAudio
                            ? Icons.volume_up
                            : Icons.volume_off,
                        size: 20,
                      ),
                      tooltip: AppConstants.audioTooltip,
                      color: _viewModel.autoPlayAudio
                          ? colorScheme.primary
                          : Colors.grey,
                      onPressed: _viewModel.toggleAutoPlayAudio,
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      tooltip: AppConstants.clearTooltip,
                      color: Colors.grey[700],
                      onPressed: _viewModel.clearConversation,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: AppTheme.surface,
                  child: conversation.isEmpty && !isListening
                      ? Center(
                          child: AnimateInEffect(
                            duration: const Duration(milliseconds: 1000),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(30),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Image.asset(
                                      AppConstants.logoIcon,
                                      height: 100,
                                      errorBuilder: (c, e, s) => Icon(
                                        Icons.graphic_eq,
                                        size: 80,
                                        color: colorScheme.primary
                                            .withValues(alpha: 0.3),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  AppConstants.readyPromptTitle,
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  AppConstants.readyPromptSubtitle,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          itemCount:
                              conversation.length + (isListening ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (isListening &&
                                index == conversation.length) {
                              return ListeningIndicator(
                                partialText: _viewModel.partialText,
                              );
                            }
                            return AnimateInEffect(
                              key: ValueKey(index),
                              child: ChatBubble(
                                item: conversation[index],
                                onSpeak: _viewModel.speakText,
                              ),
                            );
                          },
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.05),
                      blurRadius: 30,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Portuguese button
                    MicButton(
                      langName: 'Português',
                      langCode: AppConstants.ptLocale,
                      gradientColors: AppTheme.ptGradient,
                      isActive:
                          isListening && _viewModel.activeLangId == AppConstants.ptLocale,
                      isOtherActive:
                          isListening && _viewModel.activeLangId != AppConstants.ptLocale,
                      onTap: () =>
                          _viewModel.toggleListening(AppConstants.ptLocale),
                    ),
                    // English button
                    MicButton(
                      langName: 'Inglês',
                      langCode: AppConstants.enLocale,
                      gradientColors: AppTheme.enGradient,
                      isActive:
                          isListening && _viewModel.activeLangId == AppConstants.enLocale,
                      isOtherActive:
                          isListening && _viewModel.activeLangId != AppConstants.enLocale,
                      onTap: () =>
                          _viewModel.toggleListening(AppConstants.enLocale),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
