import api from '../lib/api';

export const getLatestKMeansRun = async (periodeId) => {
  const response = await api.get('/kmeans/runs/latest', {
    params: { periodeId },
  });
  return response.data?.data;
};

export const getKMeansCentroids = async (periodeId, iterationNumber) => {
  const response = await api.get(
    `/kmeans/runs/latest/iterations/${iterationNumber}/centroids`,
    { params: { periodeId } }
  );
  return response.data?.data;
};

export const runKMeans = async (periodeId) => {
  const response = await api.post('/kmeans/runs', null, {
    params: { periodeId },
  });
  return response.data?.data;
};
