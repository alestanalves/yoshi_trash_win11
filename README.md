# RecycleBin Custom Icons (Win11) — sem refresh forçado

Troque os ícones da **Lixeira** no Windows 11 por dois `.ico` (ex.: “magro” para vazia e “gordo” para cheia) usando um script simples **sem** nenhum refresh manual/automático embutido.

> Nota de direitos autorais: não inclua material protegido (ex.: personagens licenciados) no repositório. Publique só seus próprios ícones ou arte livre.

---

## Requisitos
- Windows 11
- PowerShell (padrão do sistema)
- Dois arquivos `.ico` com múltiplas resoluções (16, 32, 48, 64, 128, 256) e transparência.

---

## Como fazer **com o script**

1. Coloque seus ícones na pasta do projeto, por exemplo:
   - `mario_magro.ico` (Lixeira vazia)
   - `mario_gordo.ico` (Lixeira cheia)

2. Execute no PowerShell, na pasta do projeto:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1 -EmptyIcon .\mario_magro.ico -FullIcon .\mario_gordo.ico
