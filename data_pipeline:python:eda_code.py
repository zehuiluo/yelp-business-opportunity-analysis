from pathlib import Path
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
def show_current() -> None:
    plt.tight_layout()
    plt.show()
    plt.close()

def main() -> None:
    sns.set_theme(style="whitegrid")
    base = Path(__file__).resolve().parent

    restaurants = pd.read_csv(base / "dim_restaurant_new.csv")
    users = pd.read_csv(base / "dim_user.csv")
    users["yelping_since"] = pd.to_datetime(users["yelping_since"])
    users["yelping_year"] = users["yelping_since"].dt.year


    sns.histplot(restaurants["stars"], bins=20, kde=True)
    plt.title("Restaurant star ratings")
    plt.xlabel("Stars")
    plt.ylabel("Count")
    show_current()

    sns.histplot(restaurants["review_count"], bins=50, log_scale=True)
    plt.title("Restaurant review_count (log scale)")
    plt.xlabel("Review count (log10)")
    plt.ylabel("Count")
    show_current()

    cat_counts = restaurants["category"].value_counts().head(10)
    sns.barplot(x=cat_counts.values, y=cat_counts.index, orient="h")
    plt.title("Top 10 restaurant categories")
    plt.xlabel("Number of restaurants")
    plt.ylabel("Category")
    show_current()

    city_counts = restaurants["city"].value_counts().head(10)
    sns.barplot(x=city_counts.values, y=city_counts.index, orient="h")
    plt.title("Top 10 cities by restaurant count")
    plt.xlabel("Number of restaurants")
    plt.ylabel("City")
    show_current()

    sns.histplot(users["average_stars"], bins=30, kde=True)
    plt.title("User average stars")
    plt.xlabel("Average stars")
    plt.ylabel("Users")
    show_current()

    sns.histplot(users["review_count"], bins=60, log_scale=True)
    plt.title("User review_count (log scale)")
    plt.xlabel("Review count (log10)")
    plt.ylabel("Users")
    show_current()

    sns.histplot(users["fans"], bins=50, log_scale=True)
    plt.title("User fans (log scale)")
    plt.xlabel("Fans (log10)")
    plt.ylabel("Users")
    show_current()

    year_counts = users["yelping_year"].value_counts().sort_index()
    plt.plot(year_counts.index, year_counts.values, marker="o")
    plt.title("Users by join year")
    plt.xlabel("Year")
    plt.ylabel("Number of users")
    plt.xticks(rotation=45)
    show_current()

    user_corr = users[["review_count", "fans", "useful", "funny", "cool", "average_stars"]].corr()
    sns.heatmap(user_corr, annot=True, cmap="Blues", fmt=".2f")
    plt.title("User metrics correlation")
    show_current()


if __name__ == "__main__":
    main()
