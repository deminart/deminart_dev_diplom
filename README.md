enjoy :)

Инструкция по развертыванию инфраструктуры и приложения sf
1. Развертывание инфраструктуры с помощью Terraform
Шаг 1: Подготовка
1.	Клонируйте репозиторий с кодом:
2.	Убедитесь, что у вас есть настроенные креды для выбранного облачного провайдера (например, Яндекс.Облако или AWS).
Шаг 2: Настройка Terraform
1.	Откройте файл terraform/main.tf и настройте его в зависимости от вашего облачного провайдера:
	Убедитесь, что правильно настроены параметры для создания виртуальных машин (например, для мастера Kubernetes, рабочего узла и srv-сервера).
	Убедитесь, что для каждой машины настроены необходимые security group'и и доступы по SSH.
2.	В terraform/variable.tf проверьте значения переменных, таких как регионы, образы виртуальных машин, размеры и т. д.
Шаг 3: Инициализация Terraform
1.	Перейдите в папку terraform и инициализируйте Terraform:
terraform init
2.	Примените конфигурацию:
terraform apply
3.	Подтвердите создание ресурсов, введя yes.
Шаг 4: Получение доступа
1.	Получите публичные IP-адреса для виртуальных машин, созданных в облаке. Эти адреса понадобятся для доступа к Kubernetes и серверу srv.
2.	Подключитесь к серверу srv через SSH:
ssh <username>@<srv-ip>
2. Настройка серверов с помощью Ansible
Шаг 1: Подготовка
1.	Клонируйте репозиторий с Ansible конфигурациями:
git clone <URL-репозитория>
cd <папка-проекта>/ansible
2.	Настройте файл inventory.ini для добавления IP-адресов серверов (Kubernetes master, app и srv-сервера).
Шаг 2: Запуск плейбуков Ansible
1.	Запустите плейбук для установки Kubernetes и необходимых пакетов на все серверы:
ansible-playbook -i inventory.ini Install_kuber.yaml
2.	Если нужно установить дополнительные пакеты на сервер srv (например, для CI/CD или мониторинга):
ansible-playbook -i inventory.ini Install_other_app.yaml
Шаг 3: Проверка
1.	Убедитесь, что на всех серверах установлены необходимые пакеты (например, Kubernetes, Docker, GitLab Runner, Prometheus, Grafana).
3. Сборка и деплой приложения в Kubernetes
Шаг 1: Настройка CI/CD
1.	Склонируйте репозиторий с Django приложением:
git clone https://github.com/vinhlee95/django-pg-docker-tutorial.git
cd django-pg-docker-tutorial
2.	Настройте пайплайн в GitLab (или другой CI/CD системе) для автоматической сборки Docker-образов:
	Убедитесь, что Dockerfile правильный и настроен для сборки вашего Django приложения.
	Настройте отправку образа в Docker Registry.
Шаг 2: Написание Helm Chart
1.	В папке helm/Chart-app создайте Helm Chart для деплоя:
	Опишите контейнер с вашим приложением.
	Опишите контейнер с PostgreSQL.
	Используйте Persistent Volumes для базы данных.
2.	Убедитесь, что в values.yaml настроены параметры для вашего приложения (например, переменные окружения, настройки базы данных).
Шаг 3: Деплой приложения
1.	Примените Helm Chart в ваш Kubernetes кластер:
helm install my-app ./helm/Chart-app
2.	Проверьте, что приложение развернулось:
kubectl get pods
3.	Получите внешний IP для доступа к приложению:
kubectl get svc
Шаг 4: Проверка
1.	Откройте браузер и перейдите по IP-адресу или домену, чтобы проверить, что приложение доступно.
4. Настройка мониторинга и логирования
Шаг 1: Установка Prometheus и Grafana
1.	Установите Prometheus и Grafana на сервер srv для мониторинга Kubernetes и вашего приложения:
ansible-playbook -i inventory.ini Install_monitoring.yaml
2.	Убедитесь, что метрики собираются с ваших подов и отображаются в Grafana.
Шаг 2: Настройка логирования
1.	Установите EFK стек (Elasticsearch, Fluentd, Kibana) или другой инструмент для логирования на сервер srv.
2.	Настройте сбор логов с подов Kubernetes и их отображение в Kibana.
5. Настройка алертинга
Шаг 1: Алерты в Prometheus
1.	Настройте правила алертинга в Prometheus для уведомлений о проблемах с приложением (например, если оно недоступно или высокое время отклика).
2.	Убедитесь, что уведомления приходят через ваш мессенджер (например, Slack или Telegram).
Шаг 2: Тестирование
1.	Протестируйте систему, «убив» приложение или сымитировав сбой, и проверьте, что уведомление приходит в течение разумного времени.
