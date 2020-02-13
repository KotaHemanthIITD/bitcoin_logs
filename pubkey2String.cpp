#include <iostream>
#include <sstream>
#include <cryptopp/eccrypto.h>
#include <cryptopp/osrng.h>
#include <cryptopp/oids.h>
#include <cryptopp/keccak.h>

using namespace std;
using namespace CryptoPP;

int main(){
	AutoSeededRandomPool prndm;
	ECDSA<ECP,SHA256>::PrivateKey pvk;
	ECDSA<ECP,SHA256>::PublicKey pbk;
        pvk.Initialize(prndm,ASN1::secp256k1());
	pvk.MakePublicKey(pbk);
	std::string pbkstr;
	StringSink ss(pbkstr);
	pbk.Save(ss);
	Keccak_256 hsh;
	hsh.Update((const byte *)&pbkstr[0],pbkstr.size());
	uint8_t val[20];
	hsh.TruncatedFinal(val,20);

	std::ostringstream convert;
	for (int a = 0; a < 20; a++) {
   		convert << val[a];
	}

	std::string key_string = convert.str();

	std::cout << key_string << ":--:"<< key_string.size() << std::endl;	

	cout<<pbkstr.size()<<endl;
	return 0;
}
