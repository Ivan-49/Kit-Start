# Kit-Start

Kit-Start — набор Bash-скриптов для установки и настройки окружения разработчика на Ubuntu.

Проект использует профили: `minimal`, `python`, `cpp`, `backend`, `full`. PostgreSQL и Redis устанавливаются только как клиентские утилиты: серверы БД предполагается запускать в Docker. Пользователь намеренно не добавляется в группу `docker`; команды Docker выполняются через `sudo`.

## Поддерживаемые системы

- Ubuntu 22.04, 24.04 и 26.04 (совместимость пакетов зависит от репозиториев конкретного релиза).
- Архитектуры `amd64` и `arm64`.

## Состав

| Компонент | Инструменты |
|---|---|
| База | Git, Git LFS, curl, wget, архиваторы, OpenSSH client |
| Терминал | Zsh, Oh My Zsh, Powerlevel10k, Meslo Nerd Font, fzf, zoxide, ripgrep |
| Python | Python 3, uv, Ruff, pytest, mypy, pre-commit, IPython |
| C/C++ | GCC/G++, Clang, GDB, CMake, Ninja, Make, clang-format, clang-tidy, Valgrind |
| Backend | Node.js LTS через NVM, Docker Engine, Compose, Buildx |
| Базы данных | PostgreSQL client, Redis CLI, SQLite |
| Сеть | iproute2, dnsutils, nmap, tcpdump, mtr, traceroute, HTTPie |
| GUI | VS Code, DBeaver Community, Bruno через Flatpak |
| Редактор | Neovim и конфигурация из отдельного репозитория |

## Установка

```bash
git clone https://github.com/Ivan-49/Kit-Start.git
cd Kit-Start
chmod +x install.sh tests/*.sh
./install.sh --profile minimal
```

Перед установкой можно посмотреть план:

```bash
./install.sh --profile full --dry-run
```

Параметры:

```text
--profile minimal|python|cpp|backend|full
--dry-run
--no-gui
--no-system-update
--help
```

Примеры:

```bash
./install.sh --profile python
./install.sh --profile cpp
./install.sh --profile backend --no-gui
./install.sh --profile full
```

## Профили

| Профиль | Назначение |
|---|---|
| `minimal` | Системные утилиты, Git, Zsh, шрифты, Neovim |
| `python` | Базовый профиль и Python-инструменты |
| `cpp` | Базовый профиль и C/C++ toolchain |
| `backend` | Python, Node.js, Docker, клиенты БД, сеть и GUI |
| `full` | Все основные инструменты |

## Проверка

```bash
make syntax
make check
make lint
make test
```

`--dry-run` показывает команды, но не заменяет проверку установки в чистой виртуальной машине. Перед использованием на основной системе рекомендуется сначала проверить профиль в VM.

## Конфигурация

- Zsh-настройки устанавливаются в `~/.config/zsh`.
- Конфигурация Neovim клонируется из [Ivan-49/nvim](https://github.com/Ivan-49/nvim) в `~/.config/nvim`. Существующая непустая конфигурация не перезаписывается.
- Для Docker используется `sudo`; группа `docker` не назначается.
- PostgreSQL и Redis server на хост не устанавливаются.

## Безопасность и ограничения

Скрипт выполняет системные операции через `sudo` и загружает отдельные компоненты из официальных репозиториев их проектов. Перед запуском просмотрите исходный код. Фактическую доступность пакетов и сторонних репозиториев проверяйте на целевой версии Ubuntu.

## Лицензия

MIT. См. [LICENSE](LICENSE).
