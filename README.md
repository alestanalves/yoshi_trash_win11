# RecycleBin Custom Icons (Win11) — sem refresh forçado

Troque os ícones da **Lixeira** no Windows 11 por dois `.ico` (ex.: “magro” para vazia e “gordo” para cheia) usando um script simples 
---

## Requisitos
- Windows 11
- PowerShell (padrão do sistema)
- Dois arquivos `.ico` com múltiplas resoluções (16, 32, 48, 64, 128, 256) e transparência.

---

## Como fazer **com o script**

1. Coloque seus ícones na pasta do projeto, por exemplo:
   - `2.ico` (Lixeira vazia)
   - `1.ico` (Lixeira cheia)

2. Execute no PowerShell, na pasta do projeto:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1 -EmptyIcon .\2.ico -FullIcon .\1.ico

## Como fazer sem o script (via interface do Windows)

- Clique com o botão direito no desktop → Personalizar.
- Acesse Temas → Configurações de ícones da área de trabalho.
- Selecione Lixeira (vazia) → Alterar ícone... e aponte para o seu .ico “vazio”.
- Selecione Lixeira (cheia) → Alterar ícone... e aponte para o seu .ico “cheio”.
- OK → Aplicar → OK.
