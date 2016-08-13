function pdf = gmm_pdf(data, means, covs, priors, K)
    n = size(data,2);
    pdf = zeros(n,1);
    for k=1:K
        tmp = mypdf(data', means(k,:)', covs(:, :, k));
        pdf = pdf + priors(k) * tmp;
    end
end