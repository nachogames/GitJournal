import 'package:test/test.dart';

import 'package:gitjournal/ssh/rsa_key_pair.dart';

void main() {
  test('Should generate and verify keys', () async {
    var pair = RsaKeyPair.generate();
    expect(pair.isValid(), true);
  });

  test('Should async generate and verify keys', () async {
    var pair = await RsaKeyPair.generateAsync();
    expect(pair.isValid(), true);
  });

  var publicKeySingleLine =
      'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAiL0jjDdFqK/kYThqKt7THrjABTPWvXmB3URIpGKCP/jZlSuCUP3Oc+IxuFeXSIMvVIYeW2PZAjXQGTn60XzPHr+M0NoGcPAvzZf2u57aX3YKaL93cZSBHR97H+XhcYdrm7ATwfjMDgfgj7+VTvW4nI46Z+qjxmYifc8uVELolg1TDHWY789ggcdvy92oGjB0VUgMEywrOP+LS0DgG4dmkoUBWGP9dvYcPZDUF4q0XY9ZHhvyPWEZ3o2vETTrEJr9QHYwgjmFfJn2VFNnD/4qeDDHOmSlDgEOfQcZIm+XUOn9eVsv//dAPSY/yMJXf8d0ZSm+VS29QShMjA4R+7yh5WhsIhouBRno2PpEVVb37Xwe3V6U3o9UnQ3ADtL75DbrZ5beNWcmKzlJ7jVX5QzHSBAnePbBx/fyeP/f144xPtJWB3jW/kXjtPyWjpzGndaPQ0WgXkbf8fvIuB3NJTTcZ7PeIKnLaMIzT5XNCR+xobvdC8J9d6k84/q/laJKF3G8KbRGPNwnoVg1cwWFez+dzqo2ypcTtv/20yAmz86EvuohZoWrtoWvkZLCoyxdqO93ymEjgHAn2bsIWyOODtXovxAJqPgk3dxM1f9PAEQwc1bG+Z/Gc1Fd8DncgxyhKSQzLsfWroTnIn8wsnmhPJtaZWNuT5BJa8GhnzX09g6nhbk=';
  var publicKeySsh2 = '''---- BEGIN SSH2 PUBLIC KEY ----
Comment: "rsa-key-20160402"
AAAAB3NzaC1yc2EAAAABJQAAAgEAiL0jjDdFqK/kYThqKt7THrjABTPWvXmB3URI
pGKCP/jZlSuCUP3Oc+IxuFeXSIMvVIYeW2PZAjXQGTn60XzPHr+M0NoGcPAvzZf2
u57aX3YKaL93cZSBHR97H+XhcYdrm7ATwfjMDgfgj7+VTvW4nI46Z+qjxmYifc8u
VELolg1TDHWY789ggcdvy92oGjB0VUgMEywrOP+LS0DgG4dmkoUBWGP9dvYcPZDU
F4q0XY9ZHhvyPWEZ3o2vETTrEJr9QHYwgjmFfJn2VFNnD/4qeDDHOmSlDgEOfQcZ
Im+XUOn9eVsv//dAPSY/yMJXf8d0ZSm+VS29QShMjA4R+7yh5WhsIhouBRno2PpE
VVb37Xwe3V6U3o9UnQ3ADtL75DbrZ5beNWcmKzlJ7jVX5QzHSBAnePbBx/fyeP/f
144xPtJWB3jW/kXjtPyWjpzGndaPQ0WgXkbf8fvIuB3NJTTcZ7PeIKnLaMIzT5XN
CR+xobvdC8J9d6k84/q/laJKF3G8KbRGPNwnoVg1cwWFez+dzqo2ypcTtv/20yAm
z86EvuohZoWrtoWvkZLCoyxdqO93ymEjgHAn2bsIWyOODtXovxAJqPgk3dxM1f9P
AEQwc1bG+Z/Gc1Fd8DncgxyhKSQzLsfWroTnIn8wsnmhPJtaZWNuT5BJa8GhnzX0
9g6nhbk=
---- END SSH2 PUBLIC KEY ----''';

  test('Should read from OpenSSH format', () async {
    var pair = RsaKeyPair.fromStrings(
      publicKey: publicKeySsh2,
      privateKey: "",
    );

    expect(pair.publicKeyString(), publicKeySingleLine);
  });

  test('Should read from singleline format', () async {
    var pair = RsaKeyPair.fromStrings(
      publicKey: publicKeySingleLine,
      privateKey: "",
    );

    expect(pair.publicKeyString(), publicKeySingleLine);
  });

  var privateOpenSshKey = '''-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----''';

  var privateRsaKey = '''-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----''';

  test('Should read privateOpenSshKey', () async {
    var pair = RsaKeyPair.fromStrings(
      publicKey: '',
      privateKey: privateOpenSshKey,
    );

    expect(pair.privateKeyString().isNotEmpty, true);
  });

  test('Should read privateRsaKey', () async {
    var pair = RsaKeyPair.fromStrings(
      publicKey: '',
      privateKey: privateRsaKey,
    );

    expect(pair.privateKeyString().isNotEmpty, true);
  }, skip: true);
}
