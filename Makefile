home:
	docker build --build-arg svc_name='home' -t miggylol/home:latest . && docker push miggylol/home

about:
	docker build --build-arg svc_name='about' -t miggylol/about:latest . && docker push miggylol/about
