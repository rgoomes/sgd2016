#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <string.h>

using namespace std;

mutex mtx;
string querie, db;
int nclients, nqueries;

void execute_querie(){
	string cmd = "";
	if(db == "mysql")
		cmd = "cat scripts/mysql/connect_mysql.sql queries/" + string(querie) + " | mysql -u root";
	else if(db == "postgre")
		cmd = "cat scripts/postgre/connect_postgre.sql queries/" + string(querie) + " | psql";

	system(cmd.c_str());
}

void worker(int id){
	unique_lock<std::mutex> ulock(mtx);
	execute_querie();
}

int main(int argc, char **argv){
	nclients = atoi(*++argv);
	querie = *++argv;
	db = *++argv;

	if(nclients > 1) {
		vector<std::thread> clients;

		mtx.lock();
		for(int i = 0; i < nclients; ++i)
			clients.push_back(std::thread(worker, i));
		mtx.unlock();

		for(auto &client : clients)
			client.join();
	}
	else {
		nqueries = atoi(*++argv);

		for(int i = 0; i < nqueries; ++i)
			execute_querie();
	}

	return 0;
}
