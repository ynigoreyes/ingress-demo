svc1:
	docker build --build-arg svc_name='svc1' -t miggylol/svc1:latest . && docker push miggylol/svc1

svc2:
	docker build --build-arg svc_name='svc2' -t miggylol/svc2:latest . && docker push miggylol/svc2
