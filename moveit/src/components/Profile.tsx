import styles from "../styles/components/Profile.module.css";

export function Profile() {
  return (
    <div className={styles.profileContainer}>
      <img src="https://github.com/DenysLins.png" alt="Denys Lins" />
      <div>
        <strong>Denys Lins</strong>
        <p>Level 1</p>
      </div>
    </div>
  );
}
