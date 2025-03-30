task deploy: [ "deploy:build", "deploy:push" ]

namespace :deploy do
  task setup: [ "setup:ssh", "setup:connect", "setup:ansible", "setup:vps", "setup:docker" ]

  task :build do
    if ENV["PROD_IMAGE"].blank?
      puts "Missing PROD_IMAGE environment variable"
      exit 1
    end

    puts "Building docker image..."
    sh "docker build -t #{ENV["PROD_IMAGE"]}:latest ."
  end

  task :push do
    if ENV["PROD_IMAGE"].blank?
      puts "Missing PROD_IMAGE environment variable"
      exit 1
    end

    if ENV["PROD_DOMAIN"].blank?
      puts "Missing PROD_DOMAIN environment variable"
      exit 1
    end

    if ENV["PROD_STACK"].blank?
      puts "Missing PROD_STACK environment variable"
      exit 1
    end

    puts "Pushing docker image..."
    sh "docker push #{ENV["PROD_IMAGE"]}:latest"
    sh "docker stack deploy --with-registry-auth --prune -c docker-stack.yaml #{ENV["PROD_STACK"]}"
  end

  namespace :setup do
    task :ansible do
      puts "Checking if ansible is installed..."

      begin
        sh "ansible --version"
      rescue
        puts "Ansible is not installed. Please install it and try again"
        exit 1
      end
    end

    task :connect do
      puts "Checking connection to production VPS..."

      begin
        sh "ssh prod-sys /usr/bin/true"
      rescue
        puts "Failed to connect to prod-sys"
        exit 1
      end
    end

    task :docker do
      puts "Checking if docker is installed..."

      begin
        sh "docker --version"
      rescue
        puts "Docker is not installed. Please install it and try again"
        exit 1
      end

      puts "Creating docker context..."

      if `docker context ls`.lines.grep(/^prod\b/).any?
        puts "Docker context 'prod' already exists."
        exit 1
      end

      sh %(docker context create prod --docker "host=ssh://prod-app")
      sh "docker context use prod"
    end

    task :ssh do
      puts "Checking for ssh keys..."

      prod_sys_key = File.expand_path("~/.ssh/prod-sys.key")
      prod_app_key = File.expand_path("~/.ssh/prod-app.key")

      if !File.exist?(prod_sys_key) || !File.exist?(prod_app_key)
        puts "SSH keys not found."
        puts "Generating required keys with an empty passphrase. If you don't"
        puts "want this, you can generate them yourself and put them in"
        puts "~/.ssh/prod-sys.key and ~/.ssh/prod-app.key"
        exit 1
      end

      generated = false

      if !File.exist?(prod_sys_key)
        sh "ssh-keygen -t ed25519 -f ~/.ssh/prod-sys.key -N ''"
        generated = true
      end

      if !File.exist?(prod_app_key)
        sh "ssh-keygen -t ed25519 -f ~/.ssh/prod-app.key -N ''"
        generated = true
      end

      if generated
        puts "SSH keys generated. Add the following to ~/.ssh/config:"
        puts
        puts "Host prod-sys"
        puts "  User <system user name>"
        puts "  HostName <host name>"
        puts "  IdentityFile ~/.ssh/prod-sys.key"
        puts
        puts "Host prod-app"
        puts "  User <app user name>"
        puts "  HostName <host name>"
        puts "  IdentityFile ~/.ssh/prod-app.key"
        puts
        puts "Then run 'rails deploy:setup' again."
        exit 0
      end
    end

    task :vps do
      puts "Configuring VPS..."

      sh "ansible-playbook -i deploy/inventory.yaml deploy/production.yaml"
    end
  end
end
