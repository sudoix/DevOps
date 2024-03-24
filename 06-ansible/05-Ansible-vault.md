# Ansible vault

Ansible Vault is a feature of Ansible that allows you to keep sensitive data such as passwords or keys in encrypted files, rather than as plaintext in your playbooks or roles. This is crucial for managing and deploying sensitive data securely.

### Key Features of Ansible Vault:
- **Encryption and Decryption:** Ansible Vault can encrypt entire files, variable files, or even specific variables within a playbook. It can also decrypt them on the fly during playbook runs.
- **Password Protected:** The encrypted files are password-protected. You need the password to view, edit, decrypt, or use the encrypted files in playbook runs.
- **Integrated with Ansible Playbooks and Roles:** Ansible Vault is fully integrated with Ansible playbooks and roles. Encrypted data can be used just like unencrypted data, provided you supply the vault password.
- **Multiple Vault Passwords:** Ansible supports using multiple vault passwords for different roles or environments, enhancing security by segregating access to sensitive data.

### Basic Commands:
- **Creating Encrypted Files:** To create a new encrypted file, you use the command `ansible-vault create filename.yml`. This command prompts you for a vault password and then opens an editor for you to enter the file's contents.
- **Editing Encrypted Files:** To edit an existing encrypted file, you can use `ansible-vault edit filename.yml`. You'll need to provide the vault password to make changes.
- **Encrypting Existing Files:** If you have an existing file that you want to encrypt, you can use `ansible-vault encrypt filename.yml`.
- **Decrypting Files:** To decrypt an encrypted file, use `ansible-vault decrypt filename.yml`.
- **Viewing Encrypted Files:** To view the contents of an encrypted file without decrypting it, you can use `ansible-vault view filename.yml`.

### Using Encrypted Data in Playbooks:
To use encrypted data within a playbook, you generally need to provide the vault password. This can be done in several ways:
- **Interactively:** By running ansible-playbook commands without any extra flags, and Ansible will prompt you for the vault password.
- **Vault Password File:** You can store the vault password in a file (ensuring this file itself is secured) and reference it with `--vault-password-file` when running your playbook.
- **Asking for Vault Passwords:** With the `--ask-vault-pass` flag, you can tell Ansible to prompt you for the vault password when you run your playbooks.

### Example:
Here's a simple example of how you might use Ansible Vault to encrypt a variable:

First, you create an encrypted file:
```shell
ansible-vault create secrets.yml
```

Inside `secrets.yml`, you might have:
```yaml
secret_password: mySuperSecretPassword
```

In your playbook, you can then include the encrypted file:
```yaml
---
- hosts: all
  vars_files:
    - secrets.yml
  tasks:
    - name: Use secret password
      debug:
        msg: "The secret password is {{ secret_password }}"
```

```
ansible-playbook file6.yaml --ask-vault-pass -i ansible/inventory/hosts.ini -b
```

To run this playbook while decrypting the `secrets.yml` file on the fly, you would use one of the methods mentioned above to provide the vault password.

Ansible Vault is a powerful tool for managing secrets, allowing you to use Ansible for sensitive deployments securely.


## vault-id

Using `--vault-id` with Ansible Vault is a more flexible way to handle multiple encrypted files or variables within the same project, potentially encrypted with different passwords. This approach allows you to assign identifiers to your vault passwords and specify which identifier to use for encryption or decryption operations. It's particularly useful in complex environments where different teams or roles may have access to specific sets of secrets.

### Step 1: Creating Vault Password Files with IDs

First, create the vault password files that will store the passwords. Ensure these files are stored securely and access to them is restricted. Let's assume you create two files:

1. `/path/to/vault_password_file_prod` for production secrets.
2. `/path/to/vault_password_file_dev` for development secrets.

### Step 2: Encrypting Files or Variables Using `--vault-id`

When encrypting files or variables, you can specify an identifier for the vault-id. This ID will be associated with the encrypted content, making it easier to manage multiple vaults.

To encrypt a file for production use:

vim secret_prod.yml

```yaml
admin_pass: As123446
```

vim vault_password_file_prod

```
test123
```

```shell
ansible-vault encrypt secret_prod.yml --vault-id prod@/path/to/vault_password_file_prod
```

### Step 3: Referencing Encrypted Variables in Your Playbook

You can reference the encrypted variables in your playbook just like any other variables. Here's an example playbook:

```yaml
---
- name: Example playbook using different vault-ids
  hosts: all
  vars_files:
    - secret_prod.yml
  tasks:
    - name: Display the secret for prod
      debug:
        msg: "The production secret is {{ admin_pass }}"
```

### Step 4: Running the Playbook with Multiple `--vault-id`

When running the playbook, you can specify each `--vault-id` to provide the appropriate passwords for decrypting both the production and development secrets.

```shell
ansible-playbook file4.yaml  -i ansible/inventory/hosts.ini -b --vault-id prod@vault_password_file_prod
```

In this command, Ansible uses the specified vault-ids and their corresponding password files to decrypt any encrypted data it encounters in the playbook. This setup allows you to easily manage and use multiple sets of secrets within the same Ansible project, enhancing security and flexibility in complex environments.

The use of `--vault-id` makes it straightforward to separate and manage access to sensitive data according to different environments or roles, supporting better security practices in your infrastructure management.


### encrypt_string

`ansible-vault encrypt_string` is a useful command for encrypting specific strings directly from the command line, without needing to encrypt an entire file. This feature is handy for encrypting individual variables or secrets that you then include directly in your Ansible playbooks or variable files in an encrypted form.

### Example Scenario

Suppose you have a sensitive API key that you need to use in your playbook. You want to encrypt this string to safely store it in your Ansible project.

### Step 1: Encrypting the String

First, encrypt the API key (let's say your API key is `12345abcde`) using the `ansible-vault encrypt_string` command. You can optionally provide a `vault-id` or `--vault-password-file`, but for simplicity, we'll encrypt it with a prompt for the vault password.

```bash
ansible-vault encrypt_string '12345abcde' --name 'api_key'
```

When you run this command, Ansible prompts you to enter a **vault password**. After entering the password twice, Ansible outputs the encrypted string, which looks something like this:

```yaml
api_key: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          66386439653266373934616566653062386234326136643062313435356465653262343839316264
          6239313837363562663039346665373937356338653861620a396662373966663931346638626133
          35646663366261616634386636613162393162323239373139653465643339613864336164653933
          3537646165663461300a386137333864356466613434613931623334303563646537353964316234
          3965
```

### Step 2: Including the Encrypted String in a Playbook or Variable File

You can then include this encrypted string directly in your playbook or a variable file. Here's an example of how you might use it in a playbook:

```yaml
---
- name: Use encrypted API key
  hosts: web
  vars:
    api_key: !vault |
            $ANSIBLE_VAULT;1.1;AES256
            66386439653266373934616566653062386234326136643062313435356465653262343839316264
            6239313837363562663039346665373937356338653861620a396662373966663931346638626133
            35646663366261616634386636613162393162323239373139653465643339613864336164653933
            3537646165663461300a386137333864356466613434613931623334303563646537353964316234
            3965
  tasks:
    - name: Display the decrypted API key
      debug:
        msg: "The API key is: {{ api_key }}"
```

### Step 3: Running the Playbook with the Vault Password

To run the playbook and decrypt the `api_key` variable on the fly, you'll need to provide the vault password. This can be done either by using the `--ask-vault-pass` flag to input the password interactively or by using a vault password file with the `--vault-password-file` option.

```bash
ansible-playbook file4.yaml  -i ansible/inventory/hosts.ini -b --ask-vault-pass
```

or

vim pass.txt

```
# put your vault pass
123
```


```bash
ansible-playbook file4.yaml  -i ansible/inventory/hosts.ini -b --vault-password-file pass.txt
```

This approach allows you to securely manage sensitive data such as passwords, keys, and other secrets directly within your Ansible playbooks or variable files, with the data encrypted using Ansible Vault's strong encryption.