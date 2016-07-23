function pdf = gmm_pdf(data, means, covs, priors, K)
    n = size(data,2);
    pdf = zeros(n,1);
    for k=1:K
        pdf = pdf + priors(k) * mvnpdf(data', means(k,:), covs(:, :, k));
    end
end