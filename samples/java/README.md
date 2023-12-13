## Add CA to JAVA cacerts

``` bash
keytool -import -alias contoso -keystore "<cacerts path>" -file contoso.ca.crt
```

## JAVA cacerts default password

``` bash
changeit
```