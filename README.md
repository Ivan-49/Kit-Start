# Kit-Start
# Kit-Start

**Kit-Start** — набор Bash-скриптов для автоматической установки и настройки рабочего окружения разработчика на Ubuntu.

Проект позволяет быстро подготовить систему к разработке на Python, C/C++, Backend и другим направлениям. Вместо ручной установки каждого инструмента достаточно выбрать профиль и запустить один скрипт.


> **Цель проекта:** сократить время настройки новой Ubuntu-системы и обеспечить воспроизводимое окружение разработки.

## Содержание

- [Возможности](#возможности)
- [Поддерживаемые системы](#поддерживаемые-системы)
- [Устанавливаемые инструменты](#устанавливаемые-инструменты)
- [Структура проекта](#структура-проекта)
- [Установка](#установка)
- [Профили установки](#профили-установки)
- [Использование](#использование)
- [Настройка окружения](#настройка-окружения)
- [Проверка установки](#проверка-установки)
- [Особенности](#особенности)
- [Безопасность](#безопасность)
- [Лицензия](#лицензия)

## Возможности

Kit-Start автоматизирует подготовку Ubuntu к разработке:

- установка системных пакетов и инструментов разработчика;
- настройка Git;
- установка Zsh и Oh My Zsh;
- настройка терминала с Powerlevel10k;
- установка Meslo Nerd Font;
- установка Python и инструментов для работы с ним;

- установка Node.js через NVM;
- установка компиляторов и инструментов C/C++;
- установка Docker Engine, Docker Compose и Buildx;
- установка клиентов PostgreSQL, Redis и SQLite;
- установка сетевых диагностических утилит;
- установка Neovim с пользовательской конфигурацией;
- установка графических приложений через Flatpak;

- проверка корректности установки.


Установка разделена на отдельные модули. Это позволяет запускать только необходимые компоненты, не устанавливая весь набор инструментов.

## Поддерживаемые системы

| Параметр | Поддержка |
|---|---|

| Ubuntu 22.04 LTS | Да |
| Ubuntu 24.04 LTS | Да |
| Ubuntu 26.04 | Заявлена |
| Архитектура amd64 | Да |
| Архитектура arm64 | Да |

> Поддержка конкретных пакетов зависит от их доступности в репозиториях Ubuntu и сторонних репозиториях. Для Ubuntu 26.04 совместимость отдельных компонентов может потребовать дополнительной проверки.

## Устанавливаемые инструменты

### Системные утилиты

- `curl`, `wget`, `git`, `git-lfs`;
- `tree`, `btop`, `htop`, `ncdu`;
- `bat`, `eza`, `fzf`, `zoxide`, `ripgrep`, `fd-find`;
- `jq`, `yq`, `tldr`;
- `tmux`, `screen`;
- `rsync`, `lsof`;
- `zip`, `unzip`, `tar`, `gzip`, `xz-utils`;
- `openssh-client`, `gnupg`, `ca-certificates`.

### Терминал

- Zsh;
- Oh My Zsh;
- Powerlevel10k;
- Meslo Nerd Font;
- пользовательские aliases, exports и functions.

### Python


- Python 3;
- `pip`, `venv`;
- `uv`;
- Ruff;
- Pytest;
- Mypy;
- Pre-commit;
- IPython.

### C / C++

- GCC и G++;
- Clang;
- GDB;
- CMake;
- Ninja;
- Make;
- Clang Format;
- Clang Tidy;

- Valgrind;
- pkg-config.

### Backend-разработка

- Node.js через NVM;
- Go;
- GitHub CLI;
- Bruno.

### Docker

- Docker Engine;
- Docker Compose Plugin;
- Docker Buildx.


### Базы данных

Устанавливаются клиентские инструменты:


- PostgreSQL Client;
- Redis CLI;
- SQLite3;
- SQLite development libraries;
- DBeaver Community.

Серверы PostgreSQL и Redis по умолчанию не устанавливаются на хостовую систему. Для локальной разработки рекомендуется использовать Docker-контейнеры.

### Сетевые инструменты


- `iproute2`;
- `net-tools`;
- `dnsutils`;
- `nmap`;
- `tcpdump`;
- `mtr-tiny`;
- `traceroute`;
- `httpie`;
- `netcat-openbsd`.

### Графические приложения


- Visual Studio Code;
- DBeaver Community;
- Bruno.

Графические приложения устанавливаются через Flatpak.


## Структура проекта

```text
Kit-Start/

├── LICENSE
├── Makefile
├── README.md
├── install.sh
│
├── configs/
│   └── zsh/
│       ├── aliases.zsh
│       ├── exports.zsh
│       └── functions.zsh
│
├── packages/
│   ├── base.txt
│   ├── system.txt
│   ├── terminal.txt
│   ├── python.txt
│   ├── cpp.txt
│   ├── backend.txt
│   ├── database.txt
│   ├── networking.txt
│   └── optional.txt
│
├── profiles/
│   ├── minimal.sh
│   ├── python.sh

│   ├── cpp.sh
│   ├── backend.sh
│   └── full.sh

│
├── scripts/
│   ├── lib/
│   │   ├── common.sh
│   │   ├── logging.sh
│   │   ├── packages.sh
│   │   └── platform.sh
│   │
│   ├── system.sh
│   ├── git.sh
│   ├── terminal.sh
│   ├── zsh.sh
│   ├── ohmyzsh.sh
│   ├── fonts.sh
│   ├── python.sh
│   ├── nodejs.sh
│   ├── cpp.sh
│   ├── docker.sh
│   ├── database.sh
│   ├── networking.sh

│   ├── neovim.sh
│   ├── gui.sh
│   ├── optional.sh
│   └── cleanup.sh

│
└── tests/
    ├── check.sh
    └── syntax.sh
```


### Назначение основных директорий

| Директория | Назначение |

|---|---|
| `configs/` | Конфигурационные файлы пользовательского окружения |
| `packages/` | Списки устанавливаемых системных пакетов |
| `profiles/` | Наборы компонентов для разных направлений разработки |
| `scripts/` | Скрипты установки и настройки |
| `scripts/lib/` | Общие функции, используемые модулями |
| `tests/` | Проверка синтаксиса и установленного окружения |

## Установка

### 1. Клонирование репозитория


```bash

git clone https://github.com/Ivan-49/Kit-Start.git
cd Kit-Start
```


### 2. Предоставление прав на выполнение

```bash
chmod +x install.sh
chmod +x scripts/*.sh
chmod +x scripts/lib/*.sh
chmod +x tests/*.sh

```

### 3. Запуск установки


Например, для установки полного окружения:

```bash
./install.sh --profile full
```

Во время установки скрипт может запросить пароль пользователя для выполнения команд с `sudo`.

## Профили установки


В проекте предусмотрено пять профилей.


| Профиль | Назначение |
|---|---|
| `minimal` | Базовое рабочее окружение |
| `python` | Разработка на Python |
| `cpp` | Разработка на C и C++ |
| `backend` | Backend-разработка |
| `full` | Полный набор инструментов |

### Minimal

Базовое окружение для повседневной работы:

- системные утилиты;
- Git;
- Zsh;
- Oh My Zsh;
- Powerlevel10k;
- Nerd Font;
- базовая настройка терминала.

```bash
./install.sh --profile minimal

```

### Python

Окружение для разработки на Python:


- базовые инструменты;
- Python;
- uv;

- venv;
- Ruff;
- Pytest;
- Mypy;
- Pre-commit;
- IPython.

```bash
./install.sh --profile python

```

### C++

Инструменты для разработки и сборки C/C++ проектов:

- GCC и G++;
- Clang;
- GDB;
- CMake;
- Ninja;
- Make;
- Clang Format;

- Clang Tidy;
- Valgrind.

```bash
./install.sh --profile cpp
```

### Backend

Окружение для серверной разработки:

- Python;
- Node.js;
- NVM;
- Go;
- Docker;
- PostgreSQL Client;
- Redis CLI;
- SQLite;
- Bruno;
- GitHub CLI.


```bash

./install.sh --profile backend
```

### Full

Установка всех предусмотренных проектом компонентов:

```bash
./install.sh --profile full

```

## Использование

### Просмотр доступных параметров

```bash
./install.sh --help
```

### Проверочный запуск

Перед полноценной установкой можно выполнить пробный запуск:

```bash
./install.sh --profile full --dry-run
```

Режим `--dry-run` позволяет посмотреть планируемые действия без выполнения установки.

### Установка без графических приложений

```bash
./install.sh --profile full --no-gui
```

Это полезно для серверов, виртуальных машин и систем без графического интерфейса.

### Сочетание параметров

Параметры можно использовать совместно:

```bash
./install.sh --profile backend --no-gui
```


## Настройка окружения

### Neovim

Kit-Start не содержит собственной копии конфигурации Neovim.

Вместо этого используется отдельный репозиторий:

[ Ivan-49/nvim ](https://github.com/Ivan-49/nvim)

Конфигурация клонируется в:

```text
~/.config/nvim
```

Таким образом, конфигурация редактора поддерживается независимо от Kit-Start.

### Docker

После установки Docker рекомендуется проверить его работу:

```bash
sudo docker --version
sudo docker compose version
sudo docker run hello-world
```

Docker не добавляет текущего пользователя в группу `docker`. Команды выполняются через `sudo`.

### Python

Проверить установку можно следующими командами:

```bash
python3 --version
uv --version
```


Создание виртуального окружения:


```bash
uv venv
source .venv/bin/activate

```

Установка зависимости:

```bash
uv pip install fastapi
```

### Node.js

После установки NVM:


```bash

nvm --version

nvm install --lts
nvm use --lts
```


### Git

Проверка:

```bash
git --version
git lfs version
```


Имя и электронную почту для коммитов можно задать отдельно:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## Проверка установки

В проекте предусмотрены скрипты для проверки.

### Проверка синтаксиса Bash


```bash
make syntax
```


Или напрямую:

```bash
./tests/syntax.sh
```

### Проверка установленного окружения

```bash
make check
```


Или:

```bash
./tests/check.sh
```


### Проверка ShellCheck

Если ShellCheck установлен:

```bash
shellcheck install.sh scripts/*.sh scripts/lib/*.sh tests/*.sh
```

## Особенности

- **Модульность.** Каждый компонент устанавливается отдельным скриптом.
- **Профили.** Можно выбрать только необходимые инструменты.
- **Повторный запуск.** Скрипты рассчитаны на повторное выполнение без намеренного дублирования конфигураций.
- **Разделение конфигураций.** Пользовательские настройки терминала хранятся отдельно от установочной логики.

- **Docker-first для БД.** PostgreSQL и Redis не устанавливаются как серверы на хост.
- **Независимая конфигурация Neovim.** Редактор использует отдельный Git-репозиторий.

## Безопасность

Перед запуском рекомендуется ознакомиться с содержимым скриптов.


Kit-Start использует `sudo` для системных операций. Установка сторонних компонентов может обращаться к официальным репозиториям разработчиков и загружать установочные файлы из сети.

Не рекомендуется запускать установочные скрипты из неизвестных источников без предварительной проверки.

## Лицензия

Проект распространяется под лицензией MIT. Подробности находятся в файле [LICENSE](LICENSE).

---

**Автор:** [Ivan-49](https://github.com/Ivan-49)

**Проект:** [Kit-Start](https://github.com/Ivan-49/Kit-Start)
