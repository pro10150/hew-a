import pandas as pd
import numpy as np
import sqlite3
from scipy.sparse import coo_matrix, csr_matrix
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.preprocessing import LabelEncoder


def GetItemItemSim(uid, recipeId):
    recipeUserMatrix = csr_matrix(([1]*len(uid), (recipeId, uid)))
    similarity = cosine_similarity(recipeUserMatrix)
    return similarity, recipeUserMatrix


def get_recommendations_from_similarity(similarity_matrix, SalesItemCustomerMatrix, top_n=10):
    recipeUserItemMatrix = csr_matrix(SalesItemCustomerMatrix.T)
    # sum of similarities to all purchased products
    recipeUserItemScores = recipeUserItemMatrix.dot(similarity_matrix)
    RecForCust = []
    for uid in range(recipeUserItemScores.shape[0]):
        scores = recipeUserItemScores[uid, :]
        recipeIds = recipeUserItemMatrix.indices[recipeUserItemMatrix.indptr[uid]:
                                                 recipeUserItemMatrix.indptr[uid+1]]
        scores[recipeIds] = -1  # do not recommend already purchased SalesItems
        top_products_ids = np.argsort(scores)[-top_n:][::-1]
        recommendations = pd.DataFrame(
            top_products_ids.reshape(1, -1),
            index=[uid],
            columns=['Top%s' % (i+1) for i in range(top_n)])
        RecForCust.append(recommendations)
    return pd.concat(RecForCust)


def get_recommendations(view_data):
    user_label_encoder = LabelEncoder()
    uids = user_label_encoder.fit_transform(view_data.uid)
    recipe_label_encoder = LabelEncoder()
    recipeIds = recipe_label_encoder.fit_transform(view_data.recipeId)
    # compute recommendations
    similarity_matrix, recipeUserMatrix = GetItemItemSim(uids, recipeIds)
    recommendations = get_recommendations_from_similarity(
        similarity_matrix, recipeUserMatrix)
    recommendations.index = user_label_encoder.inverse_transform(
        recommendations.index)
    for i in range(recommendations.shape[1]):
        recommendations.iloc[:, i] = recipe_label_encoder.inverse_transform(
            recommendations.iloc[:, i])
        return recommendations


def getRecommendations(json, uid):
    df = pd.DataFrame.from_dict(json)

    dataPrep = df[['uid', 'recipeId', 'isView']]
    try:
        result = get_recommendations(dataPrep).loc[[uid], :].values.tolist()[0]
    except:
        result = []
    return result
