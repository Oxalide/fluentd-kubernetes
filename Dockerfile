FROM fabric8/fluentd:0.14.8

MAINTAINER Christophe Gasmi <christophe.gasmi@oxalide.com>

ENTRYPOINT ["/start-fluentd"]

ENV ELASTICSEARCH_HOST es-logging.default.svc

RUN touch /var/lib/rpm/* && yum install -y gcc-c++ && yum clean all

RUN scl enable rh-ruby23 'gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-elasticsearch -v 1.9.5' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-prometheus -v 0.2.1' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-logmatic -v 0.9.1' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-concat' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-secure-forward' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-record-reformer' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-gelf-hs' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-grok-parser' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-rewrite-tag-filter' && \
    scl enable rh-ruby23 'gem cleanup fluentd'

ADD start-fluentd /start-fluentd
