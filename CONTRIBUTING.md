# Contributing to Parley

Thank you for your interest in contributing to **Parley**! We welcome contributions from developers worldwide to help break language barriers through fast, voice-to-voice translation.

---

## Code of Conduct

We are committed to providing a friendly, safe, and welcoming environment for all contributors, regardless of experience level, gender identity, sexual orientation, disability, personal appearance, race, ethnicity, or religion. Please be respectful and constructive in all discussions.

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`>= 3.0.0 < 4.0.0`)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- Android Studio / VS Code with Flutter and Dart extensions
- Physical mobile device or emulator with microphone support

### Initial Setup

1. **Fork and clone the repository:**
   ```bash
   git clone https://github.com/pedrodavi120/parley-app.git
   cd parley_app
   ```

2. **Configure Environment Variables:**
   Copy the example environment template to create your local `.env`:
   ```bash
   cp .env.example .env
   ```
   > [!IMPORTANT]
   > Never commit `.env` or any sensitive credentials to version control. The repository's `.gitignore` is pre-configured to block sensitive environment files.

3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

4. **Verify Environment:**
   Run the test suite and static analysis:
   ```bash
   flutter test
   flutter analyze
   ```

---

## Development Workflow

1. **Create a Topic Branch:**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bugfix-name
   ```

2. **Architecture Guidelines:**
   Follow Parley's layered architecture:
   - **`lib/core/`**: Shared theme tokens, constants, and environment configurations.
   - **`lib/data/`**: Data models, external service wrappers (Speech, TTS, Translation).
   - **`lib/ui/`**: Feature presentation, ViewModels (`ChangeNotifier`), and modular widgets.
   - **Zero Mock Data in Production:** Only use mock/synthetic data in `test/`.

3. **Code Style & Quality:**
   - Adhere to effective Dart guidelines.
   - Run `flutter analyze` before committing. All changes must compile with **0 warnings and 0 errors**.
   - Add automated tests in `test/` for new services, models, and UI components. Ensure `flutter test` passes 100%.

4. **Commit Conventions:**
   We follow [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat: add offline language pack support`
   - `fix: resolve iOS microphone permission crash`
   - `docs: update translation provider guide`
   - `refactor: extract audio player to service layer`
   - `test: add unit tests for translation cache`

---

## Submitting Pull Requests

1. Push your branch to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
2. Open a Pull Request against the `main` branch.
3. Complete the PR description explaining:
   - What changes were made and why.
   - Testing steps and platform validation (Android / iOS / Desktop / Web).
   - Confirmation that no secrets or `.env` files are included.
4. Maintainers will review your PR and provide constructive feedback.

---

## Questions & Discussions

Open an issue on GitHub for bug reports, architectural questions, or feature requests. Thank you for making Parley better!
