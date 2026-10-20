# Política de Segurança

A equipe do Parley e a [Void Studio](https://www.voidstudio.com.br) tratam com rigor a segurança e a privacidade de usuários, contribuidores e sistemas.

---

## Versões com Suporte

| Versão | Suportada |
| :----- | :-------- |
| 1.0.x  | Sim       |
| < 1.0  | Não       |

---

## Reportando uma Vulnerabilidade

Caso identifique uma vulnerabilidade de segurança, exposição acidental de credenciais ou falha crítica no Parley, **não divulgue o problema publicamente através de issues ou discussões no GitHub.**

### Contato de Segurança
Envie um relatório confidencial para:
- **E-mail:** `contato@voidstudio.com.br` (ou diretamente aos mantenedores do repositório)
- **Assunto:** `[SEGURANÇA] Relatório de Vulnerabilidade Parley`

### Informações Recomendadas
Para agilizar a análise e correção, inclua:
1. Descrição clara da vulnerabilidade identificada.
2. Instruções de reprodução (passo a passo, scripts de prova de conceito ou capturas de tela).
3. Plataformas afetadas (Android, iOS, macOS, Windows, Linux, Web).
4. Avaliação preliminar de risco ou impacto potencial.

### Cronograma de Atendimento
- **Confirmação de Recebimento:** Em até 48 horas úteis.
- **Triagem e Validação:** Atualizações regulares sobre o status de resolução.
- **Correção e Lançamento:** Publicação da versão corrigida em conjunto com notas de versão (mantendo sigilo sobre os dados do pesquisador, caso solicitado).

---

## Gestão de Segredos e Segurança Open-Source

- **Zero Credenciais no Código:** Proibição estrita de chaves de API, senhas de keystores, certificados de assinatura ou tokens hardcoded no repositório.
- **Isolamento de Ambiente:** Todas as credenciais operacionais devem residir exclusivamente no `.env` (bloqueado pelo `.gitignore`).
- **Verificação Prévia:** Recomendamos o uso de ferramentas de varredura de segredos (como `git-secrets` ou `gitleaks`) antes de submeter pull requests.
