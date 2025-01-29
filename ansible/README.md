Адреса, как писалось ранее, будут доступны после сборки terraform в OUTPUT.

Файл inventory.ini

[master]
158.160.40.254

[app]
158.160.55.15

[srv]
158.160.34.167

[kuber]
ip adress master-0
ip adress app-0

1. Проверить доступ по ssh через ключи ко всем серверам
2. Запустить pipeline Install_other_app.yaml, который поставит все дополнительное ПО
3. Запустить pipeline Install_kuber.yaml, который подготовить master и node к включению в кластер
4. На сервере master нужно запустить следующие команды, скопирова после инициализации кластера команду присоединения в кластер ноды:

   sudo kubeadm init --control-plane-endpoint=158.160.40.254
   mkdir -p $HOME/.kube
   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
   sudo chown $(id -u):$(id -g) $HOME/.kube/config

5. На сервере master выполнить команду скопированную при инициализации сервера, пример ниже:

    sudo kubeadm join 158.160.40.254:6443 --token <your_token> \
	--discovery-token-ca-cert-hash sha256: <your_hash>

     
