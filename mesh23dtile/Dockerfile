FROM continuumio/miniconda3:latest

# git is needed for pip installs from git URLs;
RUN apt-get update &&  apt-get install -y git libpq-dev gcc libgl1-mesa-dev libglu1-mesa-dev --assume-yes


WORKDIR /app

# RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
#     conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
    
# Create the conda environment
COPY environment.yml .
RUN conda env create -f environment.yml && \
    conda clean -afy

# Force py3dtiles v9.0.0 (overrides the version pulled by py3dtilers)
RUN /opt/conda/envs/mesh23Dtile/bin/pip uninstall -y py3dtiles && \
    /opt/conda/envs/mesh23Dtile/bin/pip install --no-cache-dir \
        "py3dtiles @ git+https://gitlab.com/py3dtiles/py3dtiles@v9.0.0"

# Copy application code
COPY mesh23dtile.py octree.py finalize.py run.sh __init__.py ./

RUN chmod +x run.sh

ENTRYPOINT ["/app/run.sh"]
