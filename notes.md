# revoke certificate for agent

```bash
rm -rf /etc/puppetlabs/puppet/ssl/
```

# test the agent

```bash
puppet agent --test --verbose --server 192.168.4.9
```


# Using Docker as a test agent.
```bash
export PSERVER=192.168.4.9
docker run -dit --network host --name goofy_xtigyro --entrypoint /bin/bash puppet/puppet-agent
docker exec -it goofy_xtigyro bash
puppet agent -t --server ${PSERVER} --masterport 8140 --waitforcert 15 --summarize --certname ubuntu-goofy_xtigyro
puppet agent -t --server puppet-compilers --ca_server agents-to-puppet --masterport 8141 --ca_port 8140 --summarize --certname ubuntu-goofy_xtigyro
#
exit
docker rm -f goofy_xtigyro
```

# Puppet helm chart values

```yaml
puppetserver:
  name: puppetserver
  image: puppet/puppetserver
  tag: 7.9.2
  pullPolicy: IfNotPresent

  ## Mandatory Deployment of Puppet Server Master/s
  ##
  masters:
    fqdns:
      alternateServerNames: "192.168.4.9"   # Comma-separated
    service:
      type: LoadBalancer
  puppeturl: "https://github.com/jeffellin/control-repo"   #  git@github.com:$SOMEUSER/puppet.git
  puppetbasedir: /etc/puppetlabs/code/environments

## r10k Repo Configuration
##
r10k:
  code:
    readinessProbe:
      ["/bin/sh", "-ec", "test -f ~/.r10k_code_cronjob.success"]
```
