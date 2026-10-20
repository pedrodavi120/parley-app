# Contribuindo para o Parley

Agradecemos pelo seu interesse em contribuir com o **Parley**! Todas as contribuições da comunidade são bem-vindas para aprimorar a experiência de tradução simultânea voz-para-voz em tempo real.

O projeto é mantido com o suporte da [Void Studio](https://www.voidstudio.com.br).

---

## Código de Conduta

Temos o compromisso de proporcionar um ambiente acolhedor, profissional e seguro para todos os colaboradores, independentemente do nível de experiência, gênero, orientação sexual, deficiência, aparência pessoal, raça, etnia ou religião. Espera-se respeito e comunicação construtiva em todas as interações.

---

## Primeiros Passos

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`>= 3.0.0 < 4.0.0`)
- [Dart SDK](https://dart.dev/get-dart) (incluso no Flutter)
- Android Studio ou VS Code com as extensões oficiais de Flutter e Dart instaladas
- Dispositivo físico ou emulador com microfone funcional

### Configuração Inicial

1. **Faça o fork e clone o repositório:**
   ```bash
   git clone https://github.com/pedrodavi120/parley-app.git
   cd parley_app
   ```

2. **Configure as Variáveis de Ambiente:**
   Copie o modelo de variáveis de ambiente para criar o seu arquivo `.env` local:
   ```bash
   cp .env.example .env
   # No Windows PowerShell:
   Copy-Item .env.example .env
   ```
   > [!IMPORTANT]
   > Nunca submeta o arquivo `.env` ou qualquer credencial sensível para o controle de versão. O arquivo `.gitignore` do projeto está configurado para bloquear arquivos de ambiente.

3. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

4. **Valide o ambiente local:**
   Execute a suíte de testes e a análise estática:
   ```bash
   flutter test
   flutter analyze
   ```

---

## Fluxo de Desenvolvimento

1. **Crie uma branch para sua funcionalidade ou correção:**
   ```bash
   git checkout -b feature/nome-da-funcionalidade
   # ou
   git checkout -b fix/nome-da-correcao
   ```

2. **Diretrizes Arquiteturais:**
   Mantenha a arquitetura em camadas do Parley:
   - **`lib/core/`**: Configurações de ambiente, constantes globais e tokens de tema.
   - **`lib/data/`**: Modelos de dados e serviços desacoplados (Speech, TTS, Tradução).
   - **`lib/ui/`**: Camada de apresentação, ViewModels (`ChangeNotifier`) e widgets modulares.
   - **Zero Dados Falsos em Produção:** Dados simulados pertencem exclusivamente aos testes automatizados (`test/`).

3. **Estilo de Código e Rigor Técnico:**
   - Siga as diretrizes de código oficiais do Dart.
   - Execute `flutter analyze` antes de criar o commit. Todas as alterações devem compilar com **0 warnings e 0 errors**.
   - Adicione testes automatizados em `test/` para novos serviços, modelos e componentes de interface. Garanta 100% de aprovação no `flutter test`.

4. **Convenção de Commits:**
   Adotamos a especificação [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat: suporte a pacote de idiomas offline`
   - `fix: tratamento de permissao de microfone no iOS`
   - `docs: atualizacao do guia de variaveis de ambiente`
   - `refactor: modularizacao do servico de audio`
   - `test: testes unitarios para pipeline de traducao`

---

## Submissão de Pull Requests

1. Envie a branch para o seu fork:
   ```bash
   git push origin feature/nome-da-funcionalidade
   ```
2. Abra um Pull Request direcionado para a branch `main`.
3. Preencha a descrição do PR informando:
   - Resumo das alterações e motivação técnica.
   - Testes executados e validação em plataformas (Android, iOS, macOS, Windows, Linux, Web).
   - Confirmação de que nenhum arquivo `.env` ou credencial foi incluído.
4. Os mantenedores revisarão o PR com feedback técnico.

---

## Suporte e Discussões

Para relatar falhas, tirar dúvidas arquiteturais ou sugerir melhorias, abra uma Issue no GitHub.

Desenvolvido com excelência pela [Void Studio](https://www.voidstudio.com.br).
